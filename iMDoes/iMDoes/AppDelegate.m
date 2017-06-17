//
//  AppDelegate.m
//  iMDown
//
//  Created by Alexcai on 2017/6/9.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

#import "AppDelegate.h"



@interface AppDelegate ()

@property (nonatomic, strong)NSWindow *myWindow;






@end

@implementation AppDelegate



- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
   
    
}


- (BOOL)applicationShouldHandleReopen:(NSApplication *)sender hasVisibleWindows:(BOOL)flag{
    return !(flag | ([self.myWindow makeKeyAndOrderFront:self], 0));
}



#pragma  mark - Getter
- (NSWindow *)myWindow{
    if (_myWindow == nil) {
        for (NSWindow *w in NSApp.windows ) {
            if ([NSStringFromClass([w class]) isEqualToString:@"NSWindow"]){
                _myWindow = w;
                break;
            }
        }
    }
    return _myWindow;
}


@end
