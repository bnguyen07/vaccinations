//
//  QRScanViewController.h
//  Vaccinations
//
//  Created by Subash Dantuluri on 10/19/13.
//  Copyright (c) 2013 Subash Dantuluri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ZXCaptureDelegate.h>
#import "ChangePasswordViewController.h"
#import "ChangeClinicViewController.h"


@interface QRScanViewController : UIViewController <ZXCaptureDelegate,UIActionSheetDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) ChangePasswordViewController * changePwdVC;
@property (nonatomic, retain) ChangeClinicViewController * changeClinicVC;

- (IBAction)logoutAction:(id)sender;
- (IBAction)rescanPressed:(id)sender;

@end
