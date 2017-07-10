//
//  MarkdownEditView.m
//  iMDoes
//
//  Created by Alexcai on 2017/6/17.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

#import "MarkdownEditView.h"
#import "FontHelper.h"
#import "SyntaxHighLightStorage.h"
#import <AudioToolbox/AudioToolbox.h>
#import "Helper.h"

void soundCompleteCallBack(SystemSoundID soundID, void    *clientData) {}

@interface MarkdownEditView ()

@property (nonatomic, strong) SyntaxHighLightStorage *syntaxStorage;
@property (nonatomic, assign) SystemSoundID soundID;
@end



@implementation MarkdownEditView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (void)awakeFromNib{
    [super awakeFromNib];
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

- (void)keyDown:(NSEvent *)event{
    [super keyDown:event];
    BOOL isMute = [[NSUserDefaults standardUserDefaults] boolForKey:MuteKey];
    if (isMute) {return;}
    //开始播放音效
    AudioServicesPlaySystemSound(_soundID);
}



- (void)updateSyntaxHighlight{
    NSRange selectedRange = self.selectedRange;
    NSAttributedString *syntaxText = [self.syntaxStorage syntaxHighLightText:self.attributedString];
    [self.textStorage setAttributedString:syntaxText];
    selectedRange.length = 0;
    //移动光标
    self.selectedRange = selectedRange;
}
#pragma  mark - Getter
- (SyntaxHighLightStorage *)syntaxStorage{
    if (_syntaxStorage == nil) {
        _syntaxStorage = [[SyntaxHighLightStorage alloc]init];
    }
    return _syntaxStorage;
}




@end
