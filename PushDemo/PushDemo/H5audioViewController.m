//
//  H5audioViewController.m
//  PushDemo
//
//  Created by wangyangoc on 17/10/2019.
//  Copyright © 2019 wangyangoc. All rights reserved.
//

#import "H5audioViewController.h"
#import <WebKit/WebKit.h>

@interface H5audioViewController ()

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation H5audioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.webView = [[WKWebView alloc] init];
    self.webView.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));
    [self.view addSubview:self.webView];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.w3school.com.cn/tiy/t.asp?f=html5_audio_simple"]]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
