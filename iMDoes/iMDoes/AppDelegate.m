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


@interface AppDelegate () <NSMenuDelegate>

@property (weak) IBOutlet NSMenuItem *defaultThemeItem;   // 默认主题item

@property (weak) IBOutlet NSMenuItem *displayToolItem;    // 显示工具栏item
@property (weak) IBOutlet NSMenuItem *changedItem;        // 更换主题item

@property (weak) IBOutlet NSMenuItem *subHidenToolBar;

@property (weak) IBOutlet NSMenuItem *subShowToolBar;

@property (weak, nonatomic) NSMenuItem *subCurrentItem;


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
    self.statusMenu.delegate = self;
    self.currentThemeItem = self.defaultThemeItem;
    _subCurrentItem = self.subHidenToolBar;
    
    
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
    if (!NSApp.active) {return;}
   
    if (_subCurrentItem == sender) {
        return;
    }
    
    _subCurrentItem.state = NSOffState;
    sender.state = NSOnState;
    _subCurrentItem = sender;
    
    ViewController *vc = (ViewController *)NSApp.keyWindow.contentViewController;
    [vc showToolBar];
    
}


- (IBAction)exitApp:(id)sender {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [NSApp terminate:nil];
}

- (IBAction)changedTheme:(NSMenuItem *)sender {
    if ([self.currentThemeText isEqualToString:sender.title]) {return;}
    self.currentThemeText = sender.title;
    
    [[NSUserDefaults standardUserDefaults] setValue:self.currentThemeText forKey:@"ThemeKey"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    self.currentThemeItem.state = NSOffState;
    sender.state = NSOnState;
    self.currentThemeItem = sender;
    
    ViewController *vc = (ViewController *)NSApp.keyWindow.contentViewController;
    [vc updateTheme:self.currentThemeText];
}

#pragma mark - NSMenuDelegate

- (void)menuWillOpen:(NSMenu *)menu{
    
        self.displayToolItem.enabled = [self.myWindow isVisible];
        self.changedItem.enabled = [self.myWindow isVisible];
    
}


@end
