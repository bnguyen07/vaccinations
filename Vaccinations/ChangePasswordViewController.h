//
//  ChangePasswordViewController.h
//  Vaccinations
//
//  Created by Subash Dantuluri on 11/5/13.
//  Copyright (c) 2013 Subash Dantuluri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePasswordViewController : UIViewController

- (IBAction)cancelAction:(id)sender;
- (IBAction)changePassword:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *Password_Current;
@property (weak, nonatomic) IBOutlet UITextField *Password_New;
@property (weak, nonatomic) IBOutlet UITextField *Reenter_NewPassword;


@property (nonatomic, strong) NSString *physician;
@property (nonatomic, strong) NSString *user_id;

@end
