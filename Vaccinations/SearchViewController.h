//
//  SearchViewController.h
//  Vaccinations
//
//  Created by Subash Dantuluri on 10/19/13.
//  Copyright (c) 2013 Subash Dantuluri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChangePasswordViewController.h"
#import "ChangeClinicViewController.h"

@interface SearchViewController : UIViewController <UIActionSheetDelegate>
- (IBAction)logoutAction:(id)sender;
@property (nonatomic, strong) NSMutableArray *users;
- (IBAction)searchAction:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *motherMaidenName;
@property (nonatomic, retain) ChangePasswordViewController * changePwdVC;
@property (nonatomic, retain) ChangeClinicViewController * changeClinicVC;


@property (nonatomic, strong) NSString *physician_id;
@property (nonatomic, strong) NSString *user_id;

//Brian: search function
//October 23, 2013

//@property (weak, nonatomic) IBOutlet UIButton *searchPatients;
@property (nonatomic, strong) NSMutableArray *patients;
@property(strong, nonatomic) NSMutableArray *selectedPatient;

- (IBAction)dismissKeyboard:(id)sender;





@end
