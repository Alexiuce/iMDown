//
//  FontHelper.m
//  iMDoes
//
//  Created by Alexcai on 2017/6/17.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

#import "FontHelper.h"
#import <AppKit/AppKit.h>



static NSString * const defaultFont = @"Menlo-Regular";
static NSString * const boldFont = @"Menlo-Bold";
static NSString * const italicFont = @"Menlo-Italic";
static NSString * const boldItalicFont = @"Menlo-BoldItalic";

static CGFloat const fs = 15;



@implementation FontHelper


+ (NSFont *)defaultFont{
   return  [NSFont fontWithName:defaultFont size:fs];
}

+ (NSFont *)headFont{
    return [NSFont systemFontOfSize:20 weight:NSFontWeightBold];
}

+ (NSFont *)boldFont{
    return  [NSFont fontWithName:boldFont size:fs];
}
+ (NSFont *)italicFont{
    return [NSFont fontWithName:italicFont size:fs];
}

+ (NSFont *)boldItalicFont{
    return [NSFont fontWithName:boldItalicFont size:fs];
}



@end
