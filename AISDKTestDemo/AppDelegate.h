//
//  AppDelegate.h
//  AISDKTestDemo
//
//  Created by Albin on 2019/7/11.
//  Copyright © 2019 Albin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

