//
//  ViewController.m
//  PushDemo
//
//  Created by wangyangoc on 2019/8/29.
//  Copyright © 2019 wangyangoc. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <AudioToolbox/AudioToolbox.h>

#define URLFile @"http://downsc.chinaz.net/Files/DownLoad/sound1/201702/8312.wav"
//#define URLFile   @"http://downsc.chinaz.net/Files/DownLoad/sound1/201910/12079.mp3"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)appPlay:(id)sender
{
    NSURL *url = [NSURL URLWithString:URLFile];
    /* 下载路径 */
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Sounds"];
    NSString *soundFilePath = [path stringByAppendingPathComponent:url.lastPathComponent];
    SystemSoundID defaultSoundID;
    NSURL *fileURL = [NSURL fileURLWithPath:soundFilePath isDirectory:NO];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileURL, &defaultSoundID);
    AudioServicesPlaySystemSound(defaultSoundID);
}

- (IBAction)pushTapped:(id)sender
{
       UILocalNotification *notif = [[UILocalNotification alloc] init];
       // 发出推送的日期
       notif.fireDate = [NSDate dateWithTimeIntervalSinceNow:3];
       // 推送的内容
       notif.alertBody = @"你已经3秒没出现了";
       // 可以添加特定信息
       notif.userInfo = @{@"noticeId":@"00001"};
       // 角标
       notif.applicationIconBadgeNumber = 1;
       // 提示音
       //bundle路径可设置为:   @"SDKBundle.bundle/ReceiveMes.m4r"
       notif.soundName = @"ZhaoHuOASDKBundle.bundle/ReceiveMessage.m4r";
       // 每周循环提醒
       notif.repeatInterval = NSCalendarUnitWeekOfYear;
       [[UIApplication sharedApplication] scheduleLocalNotification:notif];
}

- (IBAction)pushVc:(id)sender
{
    [self.navigationController pushViewController:[NSClassFromString(@"H5audioViewController") new] animated:YES];
}

- (void)downloadSound
{
    /* 创建网络下载对象 */
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSString * urlStr = URLFile;
    /* 下载地址 */
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.timeoutInterval = 180.0f;
    /* 下载路径 */
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Sounds"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    NSString *filePath = [path stringByAppendingPathComponent:url.lastPathComponent];
    /* 开始请求下载 */
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"下载进度：%.0f％", downloadProgress.fractionCompleted * 100);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        dispatch_async(dispatch_get_main_queue(), ^{
            //如果需要进行UI操作，需要获取主线程进行操作
        });
        /* 设定下载到的位置 */
        return [NSURL fileURLWithPath:filePath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"铃声下载出错" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else {
            NSLog(@"下载完成");
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"铃声下载完成" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }];
    [downloadTask resume];
}

@end
