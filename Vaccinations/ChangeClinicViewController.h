//
//  ChangeClinicViewController.h
//  Vaccinations
//
//  Created by Subash Dantuluri on 11/5/13.
//  Copyright (c) 2013 Subash Dantuluri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeClinicViewController : UIViewController
- (IBAction)cancelAction:(id)sender;

@property (nonatomic, strong) NSString *physician;
@property (nonatomic, strong) NSString *user_id;



- (IBAction)changeClinic:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *clinic_new;
@property (weak, nonatomic) IBOutlet UITextField *reenterNew_Clinic;

@end
