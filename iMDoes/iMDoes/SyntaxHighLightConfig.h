//
//  SyntaxHighLightConfig.h
//  iMDoes
//
//  Created by Alexcai on 2017/6/17.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import "FontHelper.h"


#define COLOR_RED          [NSColor colorWithRed:0.862 green:0.196 blue:0.184 alpha:1]
#define COLOR_LIGHT_RED    [NSColor colorWithRed:0.796 green:0.294 blue:0.086 alpha:1]
#define COLOR_PURPLE       [NSColor colorWithRed:0.423 green:0.443 blue:0.768 alpha:1]
#define COLOR_DARK_PURPLE  [NSColor colorWithRed:0.305 green:0.152 blue:0.603 alpha:1]
#define COLOR_LIGHT_PINK   [NSColor colorWithRed:0.811 green:0 blue:0.603 alpha:1]
#define COLOR_GREEN        [NSColor colorWithRed:0 green:0.549 blue:0 alpha:1]
#define COLOR_BLUE_GRAY    [NSColor colorWithRed:0.576 green:0.631 blue:0.632 alpha:1]



#define defaultAttribute ({NSFont *font  = [NSFont fontWithName:defaultFont size:[FontHelper bodyFont]];\
                            @{NSFontAttributeName : font,NSForegroundColorAttributeName : [NSColor whiteColor],\
                              NSBackgroundColorAttributeName : [NSColor clearColor]};})

#define boldAttribute ({NSFont *font  = [NSFont fontWithName:boldFont size:[FontHelper bodyFont]];\
                        @{NSFontAttributeName : font,NSForegroundColorAttributeName : COLOR_RED};})

#define italicAttribute ({NSFont *font  = [NSFont fontWithName:italicFont size:[FontHelper bodyFont]];\
                          @{NSFontAttributeName : font,NSForegroundColorAttributeName : COLOR_RED};})

#define boldItalicAttribute ({NSFont *font  = [NSFont fontWithName:boldItalicFont size:[FontHelper bodyFont]];\
                              @{NSFontAttributeName : font};})

#define headerAttribute ({NSFont *font  = [NSFont fontWithName:boldFont size:[FontHelper bodyFont]];\
                         @{NSFontAttributeName:font,NSForegroundColorAttributeName : COLOR_PURPLE};})


#define linkAttribute      @{NSForegroundColorAttributeName : COLOR_PURPLE}

#define imageLinkAttribute @{NSForegroundColorAttributeName : COLOR_LIGHT_PINK}

#define codeAttribute      @{NSForegroundColorAttributeName : COLOR_GREEN}

#define listAttribute      @{NSForegroundColorAttributeName : COLOR_BLUE_GRAY}




APPKIT_EXTERN NSString * Italic ;
APPKIT_EXTERN NSString * Bold ;
APPKIT_EXTERN NSString * Header;
APPKIT_EXTERN NSString * Link;
APPKIT_EXTERN NSString * ImageLink;
APPKIT_EXTERN NSString * Code;
APPKIT_EXTERN NSString * CodeBlock;
APPKIT_EXTERN NSString * List;
APPKIT_EXTERN NSString * Clear;


