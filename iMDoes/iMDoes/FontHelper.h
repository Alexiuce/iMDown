//
//  FontHelper.h
//  iMDoes
//
//  Created by Alexcai on 2017/6/17.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>


APPKIT_EXTERN NSString * defaultFont;
APPKIT_EXTERN NSString * boldFont;
APPKIT_EXTERN NSString * italicFont;
APPKIT_EXTERN NSString * boldItalicFont;


@interface FontHelper : NSObject


+ (CGFloat)bodyFont;

@end
