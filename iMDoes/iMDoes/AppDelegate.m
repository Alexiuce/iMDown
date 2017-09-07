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

@property (weak) IBOutlet NSMenuItem *defaultThemeItem;   // 默认主题item

@property (weak) IBOutlet NSMenuItem *displayToolItem;    // 显示工具栏item
@property (weak) IBOutlet NSMenuItem *changedItem;        // 更换主题item

@property (weak) IBOutlet NSMenu *statusMenu;            // 菜单栏


@property (nonatomic, strong) NSDocument *myDocument;     // 文档编辑类
@property (nonatomic, strong) NSStatusItem *statusItem;    // 状态栏item

@property (nonatomic, copy) NSString *currentThemeText;    // 当前显示的主题名称
@property (weak, nonatomic) NSMenuItem *currentThemeItem;   // 当前选择的主题item

@end

@implementation AppDelegate



- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    self.statusItem = [[NSStatusBar systemStatusBar]statusItemWithLength:NSVariableStatusItemLength];
    self.statusItem.image = [NSImage imageNamed:@"markdown"];
//    self.statusItem.target = self;
//    self.statusItem.action = @selector(reopenWindow);
    self.statusItem.menu = self.statusMenu;
    self.currentThemeItem = self.defaultThemeItem;
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

- (IBAction)changedTheme:(NSMenuItem *)sender {
    if ([self.currentThemeText isEqualToString:sender.title]) {return;}
    self.currentThemeText = sender.title;
    
    self.currentThemeItem.state = NSOffState;
    sender.state = NSOnState;
    self.currentThemeItem = sender;
    
    ViewController *vc = (ViewController *)NSApp.keyWindow.contentViewController;
    [vc updateTheme:self.currentThemeText];
}




@end
