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


@interface MarkdownEditView ()

@property (nonatomic, strong) SyntaxHighLightStorage *syntaxStorage;

@end



@implementation MarkdownEditView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
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
