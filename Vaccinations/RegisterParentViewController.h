//
//  RegisterParentViewController.h
//  Vaccinations
//
//  Created by Brian Nguyen on 11/4/13.
//  Copyright (c) 2013 Subash Dantuluri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterParentViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *ParentUsername;
@property (weak, nonatomic) IBOutlet UITextField *ParentPassword;
@property (weak, nonatomic) IBOutlet UITextField *ParentReenterPassword;
- (IBAction)createPatientUser:(id)sender;

@end
