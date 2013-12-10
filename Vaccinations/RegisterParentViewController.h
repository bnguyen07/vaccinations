//
//  RegisterParentViewController.h
//  Vaccinations
//
//  Created by Brian Nguyen on 11/4/13.
//  Copyright (c) 2013 Subash Dantuluri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterParentViewController : UIViewController <UIAlertViewDelegate>
{
    __weak UITextField *invalidField;
}


@property (weak, nonatomic) IBOutlet UITextField *UsernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *PasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *ReenterPasswordTextField;
- (IBAction)createPatientUser:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *EmailTextField;

@property (strong, nonatomic)NSURLConnection *postNewPatientUser;
@property (strong, nonatomic) UIPopoverController *popoverController;

@end
