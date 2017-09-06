//
//  AppDelegate.m
//  iMDown
//
//  Created by Alexcai on 2017/6/9.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

#import "AppDelegate.h"
#import "TitleAccessController.h"
#import "ViewController.h"
#import "MDocument.h"


@interface AppDelegate ()


@property (weak) IBOutlet NSMenu *statusMenu;


@property (nonatomic, strong) NSDocument *myDocument;
@property (nonatomic, strong) NSStatusItem *statusItem;
@end

@implementation AppDelegate



- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    self.statusItem = [[NSStatusBar systemStatusBar]statusItemWithLength:NSVariableStatusItemLength];
    self.statusItem.image = [NSImage imageNamed:@"markdown"];
//    self.statusItem.target = self;
//    self.statusItem.action = @selector(reopenWindow);
    self.statusItem.menu = self.statusMenu;
}


- (BOOL)applicationShouldHandleReopen:(NSApplication *)sender hasVisibleWindows:(BOOL)flag{
    
    return !(flag | ([self.myWindow makeKeyAndOrderFront:nil], 0));
    
}

//- (void)reopenWindow{
//    if ([self.myWindow isVisible]) {return;}
//    
//    self.myDocument = [[MDocument alloc]init];
//    [self.myDocument makeWindowControllers];
//    [self.myDocument showWindows];
//}
- (IBAction)showToolBar:(NSMenuItem *)sender {
    if ( ![self.myWindow isVisible]) {
        sender.state = NSOffState;
        return;
    }
    
    sender.state = sender.state == NSOnState ?  NSOffState : NSOnState;
    ViewController *vc = (ViewController *)NSApp.keyWindow.contentViewController;
    [vc showToolBar];
    
}

- (IBAction)exitApp:(id)sender {
    [NSApp terminate:nil];
}





@end
