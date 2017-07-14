//
//  MYAnimation.m
//  iMDoes
//
//  Created by alexiuce  on 2017/7/14.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

#import "MYAnimation.h"

@implementation MYAnimation

- (void)setCurrentProgress:(NSAnimationProgress)currentProgress{
    [super setCurrentProgress:currentProgress];
    if ([self.myDelegate respondsToSelector:@selector(myAnimationProgress:)]) {
        [self.myDelegate myAnimationProgress:currentProgress];
    }
}

@end
