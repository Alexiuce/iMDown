//
//  TitleAccessController.m
//  iMDoes
//
//  Created by Alexcai on 2017/6/9.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

#import "TitleAccessController.h"


@interface TitleAccessController ()


@property (weak) IBOutlet NSButton *linkButton;



@end

@implementation TitleAccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)clickButton:(NSButton *)sender {
    if ([self.delegate respondsToSelector:@selector(titleAccessDidSelectedItemType:)]) {
        [self.delegate titleAccessDidSelectedItemType:sender.tag ];
    }
}


@end
