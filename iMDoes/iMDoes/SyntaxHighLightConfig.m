//
//  SyntaxHighLightConfig.m
//  iMDoes
//
//  Created by Alexcai on 2017/6/17.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

#import "SyntaxHighLightConfig.h"

NSString * Italic    = @"((_|\\*)\\w+(\\s\\w+)*(_|\\*))";
NSString * Bold      = @"((__|\\*\\*)\\w+(\\s\\w+)*(__|\\*\\*))";
NSString * Header    = @"(((^#+|\\n#+)(.*)))";
NSString * Link      = @"(\\[([^\\]]+)\\]\\(([^\\)]+)\\))";
NSString * ImageLink = @"(!\\[([^\\]]+)\\]\\(([^\\)]+)\\))";
NSString * Code      = @"(`(.*?)`)";
NSString * CodeBlock = @"(```\\w*\\n[\\w\\s\\n]*\\n```)";
NSString * List      = @"((^\\-|\\n\\-|^\\*|\\n\\*)\\s)";
NSString * Clear     = @"(^[\\w\\s\\$\\&\\+\\,\\:\\;\\=\\?\\@\\|\\'\\<\\>\\.\\^\\*\\(\\)\\%\\!\\-])";



