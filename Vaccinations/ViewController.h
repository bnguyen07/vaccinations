//
//  ViewController.h
//  Vaccinations
//
//  Created by Subash Dantuluri on 10/18/13.
//  Copyright (c) 2013 Subash Dantuluri. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *url;


@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *Username;
@property (weak, nonatomic) IBOutlet UITextField *Password;
- (IBAction)Login:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *ForgotPassword;
@property (nonatomic, strong) NSMutableArray *users;
- (IBAction)dismissKeyboard:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *RegisterParent;
- (IBAction)systemPreferenceBtn:(id)sender;

@property (strong, nonatomic) UIPopoverController *popoverControllerForgotPwd;
@property (strong, nonatomic) UIPopoverController *popoverControllerRegister;
- (IBAction)registerBtnAction:(id)sender;

@end
