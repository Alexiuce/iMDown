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
    
    if(_origText.length){
        _viewController.textView.string = _origText;
        [_viewController.textView updateSyntaxHighlight];
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

@end
