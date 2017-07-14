//
//  MYAnimation.h
//  iMDoes
//
//  Created by alexiuce  on 2017/7/14.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@protocol MYAnimationProcotol <NSObject>

- (void)myAnimationProgress:(NSAnimationProgress)progress;

@end


@interface MYAnimation : NSAnimation

@property (weak, nonatomic) id  <MYAnimationProcotol> myDelegate;

@end
