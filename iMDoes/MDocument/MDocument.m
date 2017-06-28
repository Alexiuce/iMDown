//
//  MDocument.m
//  iMDoes
//
//  Created by alexiuce  on 2017/6/28.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

#import "MDocument.h"
#import "ViewController.h"



@interface MDocument ()

@property (nonatomic, copy) NSString *origText;
@property (weak, nonatomic) ViewController *viewController;


@end


@implementation MDocument

/*
- (NSString *)windowNibName {
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return <#nibName#>;
}
*/

- (void)makeWindowControllers{
    NSStoryboard *sb = [NSStoryboard storyboardWithName:@"Main" bundle:nil];
    NSWindowController *wc = [sb instantiateControllerWithIdentifier:@"mainWindowController"];
    
    [self addWindowController:wc];
    _viewController = (ViewController *)wc.contentViewController;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(exportPdf) name:@"ConvertPdfName" object:nil];
    
    if(_origText.length){
        _viewController.textView.string = _origText;
        [_viewController.textView didChangeText];
    }
    
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController {
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError {
    NSString *text = _viewController.textView.string;
    return [text dataUsingEncoding:NSUTF8StringEncoding];
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError {
   
    _origText = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    return YES;
}

+ (BOOL)autosavesInPlace {
    return YES;
}
// 保存
- (void)exportPdf{
    NSSavePanel *panel = [NSSavePanel savePanel];
    panel.allowedFileTypes = @[@"pdf"];
//    if (self.presumedFileName)
//        panel.nameFieldStringValue = self.presumedFileName;
    
    NSWindow *w = nil;
    NSArray *windowControllers = self.windowControllers;
    if (windowControllers.count > 0)
        w = [windowControllers[0] window];
    
    [panel beginSheetModalForWindow:w completionHandler:^(NSInteger result) {
        if (result != NSFileHandlingPanelOKButton){ return;}
        
        NSDictionary *settings = @{
                                   NSPrintJobDisposition: NSPrintSaveJob,
                                   NSPrintJobSavingURL: panel.URL,
                                   };
        [self printDocumentWithSettings:settings showPrintPanel:NO delegate:nil
                       didPrintSelector:NULL contextInfo:NULL];
    }];
}
/** override */
- (void)printDocumentWithSettings:(NSDictionary<NSString *,id> *)printSettings showPrintPanel:(BOOL)showPrintPanel delegate:(id)delegate didPrintSelector:(SEL)didPrintSelector contextInfo:(void *)contextInfo{
//    self.printing = YES;
    NSInvocation *invocation = nil;
    if (delegate && didPrintSelector){
        NSMethodSignature *signature =
        [NSMethodSignature methodSignatureForSelector:didPrintSelector];
        invocation = [NSInvocation invocationWithMethodSignature:signature];
        invocation.target = delegate;
        if (contextInfo){[invocation setArgument:&contextInfo atIndex:2];}
    }
    [super printDocumentWithSettings:printSettings
                      showPrintPanel:showPrintPanel delegate:self
                    didPrintSelector:@selector(document:didPrint:context:)
                         contextInfo:(void *)invocation];
}
- (void)document:(NSDocument *)doc didPrint:(BOOL)ok context:(void *)context{
//    if ([doc respondsToSelector:@selector(setPrinting:)])
//        ((MDocument *)doc).printing = NO;
    if (context){
        NSInvocation *invocation = (__bridge NSInvocation *)context;
        if ([invocation isKindOfClass:[NSInvocation class]]){
            [invocation setArgument:&doc atIndex:0];
            [invocation setArgument:&ok atIndex:1];
            [invocation invoke];
        }
    }
}


- (NSPrintInfo *)printInfo{
    NSPrintInfo *info = [super printInfo];
    if (!info){ info = [[NSPrintInfo sharedPrintInfo] copy];}
    info.horizontalPagination = NSAutoPagination;
    info.verticalPagination = NSAutoPagination;
    info.verticallyCentered = NO;
    info.topMargin = 50.0;
    info.leftMargin = 0.0;
    info.rightMargin = 0.0;
    info.bottomMargin = 50.0;
    return info;
}

- (NSPrintOperation *)printOperationWithSettings:(NSDictionary *)printSettings error:(NSError *__autoreleasing *)e{
    NSPrintInfo *info = [self.printInfo copy];
    [info.dictionary addEntriesFromDictionary:printSettings];
    
    WebFrameView *view =   _viewController.webView.mainFrame.frameView;//self.preview.mainFrame.frameView;
    NSPrintOperation *op = [view printOperationWithPrintInfo:info];
    return op;
}
@end
