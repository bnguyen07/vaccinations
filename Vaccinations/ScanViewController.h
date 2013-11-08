//
//  ScanViewController.h
//  Vaccinations
//
//  Created by Subash Dantuluri on 10/19/13.
//  Copyright (c) 2013 Subash Dantuluri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChangePasswordViewController.h"
#import "ChangeClinicViewController.h"

@protocol ScanProtocol
- (void)logout;
@end


@interface ScanViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIActionSheetDelegate>

@property (weak) id <ScanProtocol> delegate;
@property (nonatomic, retain) ChangePasswordViewController * changePwdVC;
@property (nonatomic, retain) ChangeClinicViewController * changeClinicVC;


@property (nonatomic, strong) NSMutableArray *physician;


- (IBAction)photoLibraryButtonPressed:(id)sender;
- (IBAction)performOcrButtonPressed:(id)sender;
- (IBAction)logoutAction:(id)sender;

@end
