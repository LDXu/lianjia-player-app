//
//  AppDelegate.h
//  Pandora
//
//  Created by Mac Pro_C on 12-12-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDatabase.h"
@class HTTPServer;

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    HTTPServer *httpServer;

    NSString *firstFlag;
    int port;
}
@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) FMDatabase *db;
@property (strong,nonatomic) NSString *userId;
@property (strong,nonatomic) NSString *firstFlag;
@property (nonatomic) int port;





@end
