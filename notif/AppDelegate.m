//
//  AppDelegate.m
//  notif
//
//  Created by lkshine on 16/6/8.
//  Copyright © 2016年 lkshine. All rights reserved.
//

#import "AppDelegate.h"
#import "UMessage.h"
#import "HYBUMessageHelper.h"



#define UM_AppKey           @"5758000567e58e5288000fbc"
#define UM_AppSecret        @"fkdw7ptswzv5vqw6zauycpajkruubggz"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    [HYBUMessageHelper startWithLaunchOptions:launchOptions];
    
    //设置 AppKey 及 LaunchOptions
    [UMessage startWithAppkey:UM_AppKey launchOptions:launchOptions];
    
    //1.3.0版本开始简化初始化过程。如不需要交互式的通知，下面用下面一句话注册通知即可。
    [UMessage registerForRemoteNotifications];
    
    /**  如果你期望使用交互式(只有iOS 8.0及以上有)的通知，请参考下面注释部分的初始化代码*/
     //register remoteNotification types （iOS 8.0及其以上版本）
     UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
     action1.identifier = @"action1_identifier";
     action1.title=@"Accept";
     action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
     
     UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
     action2.identifier = @"action2_identifier";
     action2.title=@"Reject";
     action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
     action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
     action2.destructive = YES;
     
     UIMutableUserNotificationCategory *actionCategory = [[UIMutableUserNotificationCategory alloc] init];
     actionCategory.identifier = @"category1";//这组动作的唯一标示
     [actionCategory setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
     
     NSSet *categories = [NSSet setWithObject:actionCategory];
     
     //如果默认使用角标，文字和声音全部打开，请用下面的方法
     [UMessage registerForRemoteNotifications:categories];
     
     //如果对角标，文字和声音的取舍，请用下面的方法
     //UIRemoteNotificationType types7 = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
     //UIUserNotificationType types8 = UIUserNotificationTypeAlert|UIUserNotificationTypeSound|UIUserNotificationTypeBadge;
     //[UMessage registerForRemoteNotifications:categories withTypesForIos7:types7 withTypesForIos8:types8];
    
    
    //for log
    [UMessage setLogEnabled:YES];
    
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // 1.2.7版本开始不需要用户再手动注册devicetoken，SDK会自动注册
    //[UMessage registerDeviceToken:deviceToken];
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [UMessage didReceiveRemoteNotification:userInfo];
}



/*
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [HYBUMessageHelper registerDeviceToken:deviceToken];
    
    NSLog(@"%@",[[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
                  stringByReplacingOccurrencesOfString: @">" withString: @""]
                 stringByReplacingOccurrencesOfString: @" " withString: @""]);
    return;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [HYBUMessageHelper didReceiveRemoteNotification:userInfo];
    
    [HYBUMessageHelper setAutoAlertView:NO];
    return;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification
                   :(NSDictionary *)userInfo fetchCompletionHandler
                   :(void (^)(UIBackgroundFetchResult))completionHandler {
    [HYBUMessageHelper didReceiveRemoteNotification:userInfo];
    
    [HYBUMessageHelper setAutoAlertView:NO];
    completionHandler(UIBackgroundFetchResultNewData);
    return;
}  

*/


@end



