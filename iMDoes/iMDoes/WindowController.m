//
//  WindowController.m
//  iMDoes
//
//  Created by Alexcai on 2017/6/14.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

#import "WindowController.h"


@interface WindowController ()

@property (nonatomic, strong)NSStatusItem *statusItem;


@end

@implementation WindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    self.statusItem = [[NSStatusBar systemStatusBar]statusItemWithLength:NSVariableStatusItemLength];
    self.statusItem.image = [NSImage imageNamed:@"markdown"];
    self.statusItem.target = self;
    self.statusItem.action = @selector(reopenWindow);
    self.window.titlebarAppearsTransparent = YES;
//    self.window.styleMask = self.window.styleMask | NSWindowStyleMaskFullSizeContentView;
    
//    TitleAccessController *tc = [[TitleAccessController alloc]init];
//    [self.window addTitlebarAccessoryViewController:tc];
    
}


- (void)reopenWindow{
    [self.window isVisible] ? nil : [self.window makeKeyAndOrderFront:self];
}

@end
