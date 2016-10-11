//
//  AppDelegate.h
//  MapDrawingLine
//
//  Created by 李荣建 on 2016/10/11.
//  Copyright © 2016年 李荣建. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate>{
    BMKMapManager* _mapManager;

}

@property (strong, nonatomic) UIWindow *window;


@end

