//
//  TitleAccessController.m
//  iMDoes
//
//  Created by Alexcai on 2017/6/9.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

#import "TitleAccessController.h"
#import <AudioToolbox/AudioToolbox.h>


void soundCompleteCallBack(SystemSoundID soundID, void    *clientData) {}



@interface TitleAccessController ()


@property (weak) IBOutlet NSButton *linkButton;

@property (nonatomic, assign) NSInteger currentState;


@property (nonatomic, strong)id eventMonitor;
@property (nonatomic, assign) SystemSoundID soundID;

@end

@implementation TitleAccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    [self addLocalMonitor];
    
    
}
- (IBAction)clickButton:(NSButton *)sender {
    if ([self.delegate respondsToSelector:@selector(titleAccessDidSelectedItemType:)]) {
        [self.delegate titleAccessDidSelectedItemType:sender.tag ];
    }
}
- (IBAction)switchMute:(NSButton *)sender {
    sender.state = !self.currentState;
    self.currentState = sender.state;
    if (self.currentState == NSOffState) {
        [self addLocalMonitor];
    }else{
        [NSEvent removeMonitor:_eventMonitor];
    }
    
    
}


- (void)addLocalMonitor{
    NSEvent * (^monitorHandler)(NSEvent *);
    monitorHandler = ^NSEvent * (NSEvent * theEvent) {
        if (theEvent.type == NSEventTypeKeyDown) {
            //开始播放音效
            AudioServicesPlaySystemSound(_soundID);
            
        }
        return theEvent;
    };
    
    _eventMonitor = [NSEvent addLocalMonitorForEventsMatchingMask:NSEventMaskKeyDown handler:monitorHandler];

}

- (void)dealloc{
     [NSEvent removeMonitor:_eventMonitor];
}


@end
