//
//  ViewController.m
//  iMDown
//
//  Created by Alexcai on 2017/6/9.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

#import "ViewController.h"
#import "MMMarkdown.h"
#import "Helper.h"
#import "MYAnimation.h"
#import <Quartz/Quartz.h>
//#import "HGMarkdownHighlighter.h"

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

@interface ViewController()<NSTextViewDelegate,WebPolicyDelegate>
@property (weak) IBOutlet NSButton *muteButton;
@property (weak) IBOutlet NSLayoutConstraint *topBoxTop;
@property (weak) IBOutlet NSBox *toolBar;

@property (assign, nonatomic) BOOL barDisplayed;

@property (weak) IBOutlet NSLayoutConstraint *topBoxTopConstraint;

//@property (nonatomic, strong) HGMarkdownHighlighter *highlighter;

@property (nonatomic, copy) NSString *currentTheme;    // 当前主题样式


@property (nonatomic, copy) NSString *currentCss;     // 根据当前主题加载的css

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _barDisplayed = NO;
    self.textView.automaticQuoteSubstitutionEnabled = NO;
    self.textView.textColor = [NSColor whiteColor];
    self.textView.font = [NSFont systemFontOfSize:16];
    BOOL isMuted = [[NSUserDefaults standardUserDefaults] boolForKey:MuteKey];
    self.muteButton.state = isMuted ?   NSOnState :  NSOffState ;
    
//    _highlighter = [[HGMarkdownHighlighter alloc]initWithTextView:self.textView waitInterval:0.1];
//    _highlighter.parseAndHighlightAutomatically = YES;
//    [_highlighter activate];
    
    NSString *themeName = [[NSUserDefaults standardUserDefaults] valueForKey:@"ThemeKey"];
    if (themeName != nil) {
        [self updateTheme:themeName];
    }
    
}


#pragma mark WEB Delegate 
- (void)webView:(WebView *)webView decidePolicyForNavigationAction:(NSDictionary *)actionInformation request:(NSURLRequest *)request frame:(WebFrame *)frame decisionListener:(id<WebPolicyDecisionListener>)listener{
     NSString *url = request.URL.absoluteString;
    if ( [url isEqualToString:@"about:blank"]) {
        [listener use];
    }else{
        [listener ignore];
        [[NSWorkspace sharedWorkspace] openURL:request.URL];
    }
}

//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
//    NSString *url = navigationAction.request.URL.absoluteString;
//    WKNavigationActionPolicy policy = [url isEqualToString:@"about:blank"]? WKNavigationActionPolicyAllow:WKNavigationActionPolicyCancel;
//    decisionHandler(policy);
//    if (policy == WKNavigationActionPolicyCancel) {
//        [[NSWorkspace sharedWorkspace] openURL:navigationAction.request.URL];
//    }
//}


#pragma mark - NSTextViewDelegate
- (void)textDidChange:(NSNotification *)notification{
    //markdown -> html
    NSString *htmlString = [MMMarkdown HTMLStringWithMarkdown:self.textView.string extensions:MMMarkdownExtensionsGitHubFlavored error:nil];
    //加载css样式
//    static NSString *css;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        css = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Solarized (Dark)" ofType:@"css"] encoding:NSUTF8StringEncoding error:nil];
//    });
    NSString *html = [NSString stringWithFormat:@"\
                      <html>\
                      <head>\
                      <style>%@</style>\
                      </head>\
                      <body>\
                      %@\
                      </body>\
                      </html>\
                      ",self.currentCss,htmlString];
    
    [self.webView.mainFrame loadHTMLString:html baseURL:nil ];
//    [self.webView loadHTMLString:html baseURL:nil];
    [self.textView updateSyntaxHighlight];
    
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
        selectedRange.location += selectedRange.length + 2;
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
        selectedRange.location += selectedRange.length + 3;
        [self.textView insertText:insertText replacementRange:NSMakeRange(selectedRange.location, 0)];
    }else if (style == QuoteStyle){
        insertText = @"> ";
        [self.textView insertText:insertText replacementRange:NSMakeRange(selectedRange.location, 0)];
        selectedRange.location += selectedRange.length + 2;
    }
    selectedRange.length = 0;
    //移动光标
    self.textView.selectedRange = selectedRange;
}
#pragma mark - IBAction
- (IBAction)clickLink:(NSButton *)sender {
    [self titleAccessDidSelectedItemType:LinkStyle];
}
- (IBAction)clickInsertImage:(NSButton *)sender {
    [self titleAccessDidSelectedItemType:PicutreStyle];
}
- (IBAction)clickBold:(NSButton *)sender {
    [self titleAccessDidSelectedItemType:BoldStyle];
}
- (IBAction)clickDeletLine:(NSButton *)sender {
    [self titleAccessDidSelectedItemType:MiddleLineStyle];
}
- (IBAction)clickItalic:(NSButton *)sender {
    [self titleAccessDidSelectedItemType:ItalicStyle];
}
- (IBAction)clickNumberList:(NSButton *)sender {
    [self titleAccessDidSelectedItemType:NumberListStyle];
}

- (IBAction)clickNoNumberList:(NSButton *)sender {
    [self titleAccessDidSelectedItemType:ListStyle];
}
- (IBAction)clickCode:(id)sender {
    [self titleAccessDidSelectedItemType:CodeStyle];
}
- (IBAction)clickQuote:(NSButton *)sender {
    [self titleAccessDidSelectedItemType:QuoteStyle];
}

- (IBAction)clickMute:(NSButton *)sender {
    [[NSUserDefaults standardUserDefaults] setBool:sender.state == NSOnState forKey:MuteKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)clickExportHtml:(NSButton *)sender {
    NSSavePanel *panel = [NSSavePanel savePanel];
    panel.allowedFileTypes = @[@"html"];
    NSWindow *w = self.view.window;
    [panel beginSheetModalForWindow:w completionHandler:^(NSInteger result) {
        if (result != NSFileHandlingPanelOKButton){ return;}
        NSString *jsCode = @"document.documentElement.outerHTML";
        NSString *html = [self.webView stringByEvaluatingJavaScriptFromString:jsCode];
        [html writeToURL:panel.URL atomically:NO encoding:NSUTF8StringEncoding error:nil];
    }];
}
- (IBAction)clickExportPdf:(NSButton *)sender {
    if ( [self.delegate respondsToSelector:@selector(xc_exportPdf)]) {
        [self.delegate xc_exportPdf];
    }
}

- (void)showToolBar{
  
    _barDisplayed = !_barDisplayed;
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext * _Nonnull context) {
        context.duration =  0.25f;
        context.allowsImplicitAnimation = YES;
        context.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        self.topBoxTopConstraint.animator.constant = _barDisplayed ? 0 : -44;
    } completionHandler:nil];
    
    
//    MYAnimation *animation = [[MYAnimation alloc]initWithDuration:0.25 animationCurve:NSAnimationEaseInOut];
//    animation.myDelegate = self;
//    animation.animationBlockingMode = NSAnimationNonblocking;
//    [animation startAnimation];
    
    
}
//#pragma mark - MYAnimationProcotol
//- (void)myAnimationProgress:(NSAnimationProgress)progress{
//    CGFloat delat = _barDisplayed ? 1- progress : progress;
//    self.topBoxTop.constant = -44 * delat ;
//}


- (void)updateTheme:(NSString *)themeName{
    if ([self.currentTheme isEqualToString:themeName]) {return;}
    self.currentTheme = themeName;
    _currentCss =  [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:themeName ofType:@"css"] encoding:NSUTF8StringEncoding error:nil];

#pragma  clang diagnostic ignored "-Wnonnull"

    [self textDidChange:nil];
    
}


- (NSString *)currentCss{
    if (_currentCss == nil) {
        _currentCss = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"markdown" ofType:@"css"] encoding:NSUTF8StringEncoding error:nil];
    }
    return _currentCss;
}

@end
