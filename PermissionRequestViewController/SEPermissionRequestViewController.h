//
//  PermissionRequestViewController.h
//  Speakiesy
//
//  Created by Max Rogers on 7/16/15.
//  Copyright (c) 2015 Carrot Creative. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PermissionRequestDelegate;

@interface SEPermissionRequestViewController : UIViewController

@property NSMutableArray *deniedPermissions;
@property NSArray *permissions;
@property int permissionIndex;
@property UIButton *acceptButton;
@property UIButton *denyButton;
@property UIButton *askLaterButton;
@property UIImageView *graphicView;
@property UILabel *messageLabel;
@property (nonatomic, weak) id<PermissionRequestDelegate> delegate;

+ (BOOL)haveCameraAccess;
+ (BOOL)haveAudioAccess;
+ (BOOL)havePhotoRollAccess;

@end

@protocol PermissionRequestDelegate <NSObject>

- (void)permissionRequestDidComplete:(BOOL) gotAllThePermissions;
    
@end

enum {
    PermissionRequestTypeCamera = 0,
    PermissionRequestTypeMircophone = 1,
    PermissionRequestTypePhotoRoll = 2
};
typedef NSNumber PermissionRequestType;
