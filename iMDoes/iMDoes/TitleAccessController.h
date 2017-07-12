//
//  TitleAccessController.h
//  iMDoes
//
//  Created by Alexcai on 2017/6/9.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

#import <Cocoa/Cocoa.h>





@protocol TitleAccessProcotol <NSObject>

//- (void)titleAccessDidSelectedItemType:(TitleAccessStyle)style;

@end


@interface TitleAccessController : NSTitlebarAccessoryViewController

@property (nonatomic, assign) id <TitleAccessProcotol> delegate;


@end
