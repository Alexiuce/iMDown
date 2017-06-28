//
//  TitleAccessController.h
//  iMDoes
//
//  Created by Alexcai on 2017/6/9.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

#import <Cocoa/Cocoa.h>


typedef NS_ENUM(NSUInteger, TitleAccessStyle) {
     LinkStyle = 1,
     PicutreStyle,
     BoldStyle,
     MiddleLineStyle,
     ItalicStyle,
     NumberListStyle,
     ListStyle,
     CodeStyle,
     QuoteStyle
//     UptagStyle,
//     DowntagStyle
};


@protocol TitleAccessProcotol <NSObject>

- (void)titleAccessDidSelectedItemType:(TitleAccessStyle)style;

@end


@interface TitleAccessController : NSTitlebarAccessoryViewController

@property (nonatomic, assign) id <TitleAccessProcotol> delegate;


@end
