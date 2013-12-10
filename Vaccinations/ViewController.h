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
@property (weak, nonatomic) IBOutlet UITextField *UsernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *PasswordTextField;
- (IBAction)Login:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *ForgotPassword;
@property (nonatomic, strong) NSMutableArray *usersRetrievedFromDatabase;
- (IBAction)dismissKeyboard:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *RegisterParent;
- (IBAction)systemPreferenceBtn:(id)sender;

@property (strong, nonatomic) UIPopoverController *ForgotPasswordPopover;
@property (strong, nonatomic) UIPopoverController *RegisterParentPopover;


@end
