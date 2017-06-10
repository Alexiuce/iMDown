//
//  ViewController.m
//  iMDown
//
//  Created by Alexcai on 2017/6/9.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

#import "ViewController.h"
#import "TitleAccessController.h"
#import <WebKit/WebKit.h>
#import "MMMarkdown.h"

@interface ViewController()<NSTextViewDelegate,TitleAccessProcotol,WKUIDelegate,WKNavigationDelegate>

@property (weak) IBOutlet WKWebView *webView;
@property (unsafe_unretained) IBOutlet NSTextView *textView;

@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.automaticQuoteSubstitutionEnabled = NO;
    self.textView.textColor = [NSColor whiteColor];
    self.textView.font = [NSFont systemFontOfSize:16];
}


- (void)viewWillAppear{
    [super viewWillAppear];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        TitleAccessController *tc = [[TitleAccessController alloc]init];
        tc.delegate = self;
        [self.view.window addTitlebarAccessoryViewController:tc];
    });
}

#pragma mark WEB Delegate <WKUIDelegate,WKNavigationDelegate>
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSString *url = navigationAction.request.URL.absoluteString;
    WKNavigationActionPolicy policy = [url isEqualToString:@"about:blank"]? WKNavigationActionPolicyAllow:WKNavigationActionPolicyCancel;
    decisionHandler(policy);
    if (policy == WKNavigationActionPolicyCancel) {
        [[NSWorkspace sharedWorkspace] openURL:navigationAction.request.URL];
    }
}


#pragma mark - NSTextViewDelegate
- (void)textDidChange:(NSNotification *)notification{
    //markdown -> html
    NSString *htmlString = [MMMarkdown HTMLStringWithMarkdown:self.textView.string extensions:MMMarkdownExtensionsGitHubFlavored error:nil];
    //加载css样式
    static NSString *css;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        css = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"markdown" ofType:@"css"] encoding:NSUTF8StringEncoding error:nil];
    });
    NSString *html = [NSString stringWithFormat:@"\
                      <html>\
                      <head>\
                      <style>%@</style>\
                      </head>\
                      <body>\
                      %@\
                      </body>\
                      </html>\
                      ",css,htmlString];
    
    [self.webView loadHTMLString:html baseURL:nil];
    
}

#pragma  mark - TitleAccessProcotol

- (void)titleAccessDidSelectedItemType:(TitleAccessStyle)style{
    //插入的文本内容
    NSString *insertText;
    //插入文本内容后，光标的位置
    NSRange selectedRange = self.textView.selectedRange;
    if (style == LinkStyle) {
        insertText = @"[]()";
        [self.textView insertText:insertText replacementRange:selectedRange];
        selectedRange.location += 1;    //移动到 [ 后面
    }else if (style == PicutreStyle){
        insertText = @"![]()";
        [self.textView insertText:insertText replacementRange:selectedRange];
        selectedRange.location += 4;
    }else if (style == BoldStyle){
        insertText = @"**";
        [self.textView insertText:insertText replacementRange:NSMakeRange(selectedRange.location, 0)];
        selectedRange.location += selectedRange.length+2;
        [self.textView insertText:insertText replacementRange:NSMakeRange(selectedRange.location, 0)];
    }else if (style == ItalicStyle){
        insertText = @"*";
        [self.textView insertText:insertText replacementRange:NSMakeRange(selectedRange.location, 0)];
        selectedRange.location += selectedRange.length+1;
        [self.textView insertText:insertText replacementRange:NSMakeRange(selectedRange.location, 0)];
        selectedRange.location += 1;
    }else if (style == MiddleLineStyle){
        insertText = @"~~";
        [self.textView insertText:insertText replacementRange:NSMakeRange(selectedRange.location, 0)];
        selectedRange.location += selectedRange.length+2;
        [self.textView insertText:insertText replacementRange:NSMakeRange(selectedRange.location, 0)];
    }else if (style == NumberListStyle){
        insertText = @"\n1. ";
        [self.textView insertText:insertText replacementRange:NSMakeRange(selectedRange.location, 0)];
        selectedRange.location += 4;
        
    }else if (style == ListStyle){
        insertText = @"\n* ";
        [self.textView insertText:insertText replacementRange:NSMakeRange(selectedRange.location, 0)];
        selectedRange.location += 3;
    }else if (style == CodeStyle){
        insertText = @"```";
        [self.textView insertText:insertText replacementRange:NSMakeRange(selectedRange.location, 0)];
        selectedRange.location += selectedRange.length+3;
        [self.textView insertText:insertText replacementRange:NSMakeRange(selectedRange.location, 0)];
    }else if (style == QuoteStyle){
        insertText = @"> ";
        [self.textView insertText:insertText replacementRange:NSMakeRange(selectedRange.location, 0)];
        selectedRange.location += selectedRange.length+2;
    }
    selectedRange.length = 0;
    //移动光标
    self.textView.selectedRange = selectedRange;
}

@end
