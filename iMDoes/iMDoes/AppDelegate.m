//
//  AppDelegate.m
//  iMDown
//
//  Created by Alexcai on 2017/6/9.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

#import "AppDelegate.h"
#import <AudioToolbox/AudioToolbox.h>


@interface AppDelegate ()



@property (nonatomic, strong)NSWindow *window;
@property (nonatomic, strong)id eventMonitor;
@property (nonatomic, assign) SystemSoundID soundID;



@end

@implementation AppDelegate

void soundCompleteCallBack(SystemSoundID soundID, void    *clientData) {
    
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    self.window = NSApp.keyWindow;
    // Register a key listener: Command-L highlights contents of URL box in current window
    NSEvent * (^monitorHandler)(NSEvent *);
    monitorHandler = ^NSEvent * (NSEvent * theEvent) {
        if (theEvent.type == NSEventTypeKeyDown) {
            //开始播放音效
            AudioServicesPlaySystemSound(_soundID);
           
        }
        return theEvent;
    };
    
   _eventMonitor = [NSEvent addLocalMonitorForEventsMatchingMask:NSEventMaskKeyDown handler:monitorHandler];
    
    //获取音效文件路径
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"key-new-01.mp3" ofType:nil];
    //创建音效文件URL
    NSURL *fileUrl = [NSURL URLWithString:filePath];
    //音效声音的唯一标示ID
    SystemSoundID soundID = 0;
    //将音效加入到系统音效服务中，NSURL需要桥接成CFURLRef，会返回一个长整形ID，用来做音效的唯一标示
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &soundID);
    //设置音效播放完成后的回调C语言函数
    AudioServicesAddSystemSoundCompletion(soundID,NULL,NULL,soundCompleteCallBack,NULL);
    _soundID = soundID;
   
    
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
    [NSEvent removeMonitor:_eventMonitor];
}


- (BOOL)applicationShouldHandleReopen:(NSApplication *)sender hasVisibleWindows:(BOOL)flag{

    return !(flag | ([self.window makeKeyAndOrderFront:self], 0));
}



@end
