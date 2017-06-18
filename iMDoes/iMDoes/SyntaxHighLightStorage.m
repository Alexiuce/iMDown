//
//  SyntaxHighLightStorage.m
//  iMDoes
//
//  Created by Alexcai on 2017/6/17.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

#import "SyntaxHighLightStorage.h"
#import "SyntaxHighLightConfig.h"


@interface SyntaxHighLightStorage ()


@property (nonatomic, strong) NSMutableAttributedString *backStorage;

@property (nonatomic, strong) NSDictionary *replaceSyntaxDict;


@end







@implementation SyntaxHighLightStorage



- (NSAttributedString *)syntaxHighLightText:(NSAttributedString *)origText{
    _backStorage = [[NSMutableAttributedString alloc]initWithAttributedString:origText];
    
    [self defaultStyleInRange:NSMakeRange(0, self.backStorage.length)];
    [self customStyleInRange:NSMakeRange(0, self.backStorage.length)];
    
    return [_backStorage copy];
}

- (void)defaultStyleInRange:(NSRange)styleRange{
    [self.backStorage addAttributes:defaultAttribute range:styleRange];
}

- (void)customStyleInRange:(NSRange)customRange{
    [self.replaceSyntaxDict enumerateKeysAndObjectsUsingBlock:^(NSString * pattern, NSDictionary * attribute, BOOL * _Nonnull stop) {
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
        [regex enumerateMatchesInString:self.backStorage.string options:0 range:customRange usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
            NSRange matchRange = [result rangeAtIndex:1];
            [self.backStorage addAttributes:attribute range:matchRange];
        }];
    }];
}



#pragma  mark - Getter

- (NSDictionary *)replaceSyntaxDict{
    if (_replaceSyntaxDict == nil) {
        _replaceSyntaxDict = @{Italic    : italicAttribute,
                               Bold      : boldAttribute,
                               Link      : linkAttribute,
                               ImageLink : imageLinkAttribute,
                               Code      : codeAttribute,
                               CodeBlock : codeAttribute,
                               Header    : headerAttribute,
                               List      : linkAttribute
                               };
    }
    return  _replaceSyntaxDict;
}

@end
