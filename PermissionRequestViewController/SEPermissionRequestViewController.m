//
//  PermissionRequestViewController.m
//  Speakiesy
//
//  Created by Max Rogers on 7/16/15.
//  Copyright (c) 2015 Carrot Creative. All rights reserved.
//

#import "SEPermissionRequestViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@implementation SEPermissionRequestViewController

- (id)init{
    self = [super init];
    self.permissionIndex = 0;
    return self;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self setUpPromptButtons];
    [self setUpMessage];
    [self nextPermission];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - Class
+ (BOOL)haveCameraAccess{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(status == AVAuthorizationStatusAuthorized) {
        return true;
    } else {
        return false;
    }
}

+ (BOOL)haveAudioAccess{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    if(status == AVAuthorizationStatusAuthorized) {
        return true;
    } else {
        return false;
    }
}

+ (BOOL)havePhotoRollAccess{
    ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
    if (status == ALAuthorizationStatusAuthorized) {
        return true;
    }else{
        return false;
    }
}

#pragma mark - Private
- (void)setUpPromptButtons{
    _askLaterButton = [UIButton buttonWithType: UIButtonTypeSystem];
    [_askLaterButton setTitle:@"ASK LATER" forState: UIControlStateNormal];
    [_askLaterButton setTintColor: [UIColor redColor]];
    [self.view addSubview:_askLaterButton];
    [_askLaterButton addTarget:self action:@selector(skipPermission) forControlEvents: UIControlEventTouchUpInside];
    _askLaterButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint: [NSLayoutConstraint constraintWithItem:_askLaterButton
                                                           attribute:NSLayoutAttributeWidth
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.view
                                                           attribute:NSLayoutAttributeWidth
                                                          multiplier:1.0
                                                            constant:0]];
    [self.view addConstraint: [NSLayoutConstraint constraintWithItem:_askLaterButton
                                                           attribute:NSLayoutAttributeHeight
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.view
 attribute:NSLayoutAttributeHeight
                                                          multiplier:0.1
                                                            constant:0]];
    [self.view addConstraint: [NSLayoutConstraint constraintWithItem:_askLaterButton
                                                           attribute:NSLayoutAttributeBottom
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.view
                                                           attribute:NSLayoutAttributeBottom
                                                          multiplier:1.0
                                                            constant:0]];
    
//    _denyButton = [UIButton buttonWithType: UIButtonTypeSystem];
//    [_denyButton setTitle:@"DENY" forState: UIControlStateNormal];
//    [_denyButton setTintColor: [UIColor redColor]];
//    [self.view addSubview:_denyButton];
//    _denyButton.frame = CGRectMake(0, 100, 50, 50);
//    _denyButton.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.view addConstraint: [NSLayoutConstraint constraintWithItem:_denyButton
//                                                           attribute:NSLayoutAttributeWidth
//                                                           relatedBy:NSLayoutRelationEqual
//                                                              toItem:_askLaterButton
//                                                           attribute:NSLayoutAttributeWidth
//                                                          multiplier:1.0
//                                                            constant:0]];
//    [self.view addConstraint: [NSLayoutConstraint constraintWithItem:_denyButton
//                                                           attribute:NSLayoutAttributeHeight
//                                                           relatedBy:NSLayoutRelationEqual
//                                                              toItem:_askLaterButton
//                                                           attribute:NSLayoutAttributeHeight
//                                                          multiplier:1.0
//                                                            constant:0]];
//    [self.view addConstraint: [NSLayoutConstraint constraintWithItem:_denyButton
//                                                           attribute:NSLayoutAttributeBottom
//                                                           relatedBy:NSLayoutRelationEqual
//                                                              toItem:_askLaterButton
//                                                           attribute:NSLayoutAttributeTop
//                                                          multiplier:1.0
//                                                            constant:0]];
    
    _acceptButton = [UIButton buttonWithType: UIButtonTypeSystem];
    [_acceptButton setTitle:@"ACCEPT" forState: UIControlStateNormal];
    [_acceptButton setTintColor: [UIColor greenColor]];
    [self.view addSubview:_acceptButton];
    _acceptButton.frame = CGRectMake(100, 200, 50, 50);
    _acceptButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint: [NSLayoutConstraint constraintWithItem:_acceptButton
                                                           attribute:NSLayoutAttributeWidth
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:_askLaterButton
                                                           attribute:NSLayoutAttributeWidth
                                                          multiplier:1.0
                                                            constant:0]];
    [self.view addConstraint: [NSLayoutConstraint constraintWithItem:_acceptButton
                                                           attribute:NSLayoutAttributeHeight
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:_askLaterButton
                                                           attribute:NSLayoutAttributeHeight
                                                          multiplier:1.0
                                                            constant:0]];
    [self.view addConstraint: [NSLayoutConstraint constraintWithItem:_acceptButton
                                                           attribute:NSLayoutAttributeBottom
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:_askLaterButton
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1.0
                                                            constant:0]];

}

- (void)setUpMessage{
    UILabel *label = [[UILabel alloc] init];
    [label setText:@"PERMISSION REQUIRED"];
    [label setFont: [UIFont systemFontOfSize:30]];
    [self.view addSubview: label];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem: label attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:0.1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem: label attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    
    _graphicView = [[UIImageView alloc] init];
    _graphicView.image = [UIImage imageNamed:@"MicrophoneIcon"];
    [self.view addSubview:_graphicView];
    _graphicView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem: _graphicView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem: label attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem: _graphicView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem: _graphicView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.8 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem: _graphicView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.8 constant:0]];
    
    _messageLabel = [[UILabel alloc] init];
    [_messageLabel setText:[self messageGenerator:@"Microphone"]];
    [self.view addSubview: _messageLabel];
    _messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _messageLabel.numberOfLines = 0;
    _messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem: _messageLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_graphicView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem: _messageLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_graphicView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem: _messageLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
}

- (void)prepForCamera{
    [_messageLabel setText:[self messageGenerator:@"Camera"]];
    _graphicView.image = [UIImage imageNamed:@"CameraIcon"];
    [_acceptButton removeTarget:self action:@selector(requestMicrophoneAccess) forControlEvents: UIControlEventTouchUpInside];
    [_acceptButton removeTarget:self action:@selector(requestPhotoRollAccess) forControlEvents: UIControlEventTouchUpInside];
    [_acceptButton addTarget:self action:@selector(requestCameraAccess) forControlEvents: UIControlEventTouchUpInside];
}

- (void)prepForMicrophone{
    [_messageLabel setText:[self messageGenerator:@"Microphone"]];
    _graphicView.image = [UIImage imageNamed:@"MicrophoneIcon"];
    [_acceptButton addTarget:self action:@selector(requestMicrophoneAccess) forControlEvents: UIControlEventTouchUpInside];
    [_acceptButton removeTarget:self action:@selector(requestPhotoRollAccess) forControlEvents: UIControlEventTouchUpInside];
    [_acceptButton removeTarget:self action:@selector(requestCameraAccess) forControlEvents: UIControlEventTouchUpInside];
}

- (void)prepForPhotoroll{
    [_messageLabel setText:[self messageGenerator:@"Photos"]];
    _graphicView.image = [UIImage imageNamed:@"GalleryIcon"];
    [_acceptButton removeTarget:self action:@selector(requestMicrophoneAccess) forControlEvents: UIControlEventTouchUpInside];
    [_acceptButton removeTarget:self action:@selector(requestCameraAccess) forControlEvents: UIControlEventTouchUpInside];
    [_acceptButton addTarget:self action:@selector(requestPhotoRollAccess) forControlEvents: UIControlEventTouchUpInside];
}

- (void)skipPermission{
    if(!_deniedPermissions){
        _deniedPermissions = [[NSMutableArray alloc] init];
    }
    [_deniedPermissions addObject: _permissions[_permissionIndex]];
    [self proceedToNextPermission];
}

-(void) proceedToNextPermission{
    _permissionIndex++;
    [self nextPermission];
}

- (void)nextPermission{
    //First check if at end of array. If so return to original VC
    NSLog(@"%i VS %li", _permissionIndex, [_permissions count]-1 );
    if( !_permissions || !_permissions.count || _permissionIndex > _permissions.count-1){
        [self.delegate permissionRequestDidComplete:YES];
    }else{
        //Proceed to determine if permission is valid
        int permission = ((NSNumber *) _permissions[_permissionIndex]).intValue;
        if( permission ==  PermissionRequestTypeCamera){
            [self prepForCamera];
        }else if(permission ==  PermissionRequestTypeMircophone){
            [self prepForMicrophone];
        }else if(permission ==  PermissionRequestTypePhotoRoll){
            [self prepForPhotoroll];
        }else{
            //ERROR Invalid Enum
            NSLog(@"Invalid Enum");
            [self proceedToNextPermission];
        }
    }
}

- (void)requestPhotoRollAccess{
    ALAssetsLibrary *lib = [[ALAssetsLibrary alloc] init];
    [lib enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        NSLog(@"%li",(long)[group numberOfAssets]);
        [self proceedToNextPermission];
    } failureBlock:^(NSError *error) {
        if (error.code == ALAssetsLibraryAccessUserDeniedError) {
            NSLog(@"user denied access, code: %li",(long)error.code);
        }else{
            NSLog(@"Other error code: %li",(long)error.code);
        }
    }];
}

- (void)requestMicrophoneAccess{
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
        if(granted){
            NSLog(@"Granted access");
            [self proceedToNextPermission];
        } else {
            NSLog(@"Not granted access");
        }
    }];
//    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
//
//    if(status == AVAuthorizationStatusAuthorized) {
//        // authorized
//    } else if(status == AVAuthorizationStatusDenied){
//        // denied
//    } else if(status == AVAuthorizationStatusRestricted){
//        // restricted
//    } else if(status == AVAuthorizationStatusNotDetermined){
//        // not determined
//    }
}

- (void)requestCameraAccess{
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        if(granted){
            NSLog(@"Granted access");
            [self proceedToNextPermission];
        } else {
            NSLog(@"Not granted access");
        }
    }];
}

- (NSString *)messageGenerator:(NSString *)componentName{
    return [NSString stringWithFormat:@"Is it alright if this application has access to your %@?", componentName];
}

@end
