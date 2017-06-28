//
//  ViewController.h
//  iMDown
//
//  Created by Alexcai on 2017/6/9.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "HtmlView.h"
#import "MarkdownEditView.h"

@interface ViewController : NSViewController

@property (weak) IBOutlet HtmlView *webView;

@property (unsafe_unretained) IBOutlet MarkdownEditView *textView;



@end

