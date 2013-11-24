//
//  ChildDetailsViewController.h
//  Vaccinations
//
//  Created by Subash Dantuluri on 10/19/13.
//  Copyright (c) 2013 Subash Dantuluri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChildDetailsViewController : UIViewController


@property (nonatomic, strong) NSString *recordID;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTF;
@property (nonatomic, strong) NSMutableDictionary* childDict;

@property (nonatomic, strong) NSMutableDictionary* childDetails;

@property (weak, nonatomic) IBOutlet UITextField *patient_id;

@property (nonatomic, strong) NSString *physician_id;// Physician sent from Login page

- (IBAction)viewChildRecordsAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTF;
@property (weak, nonatomic) IBOutlet UITextField *recordNumber;
@property (weak, nonatomic) IBOutlet UITextField *MotherMaidenName;
@property (weak, nonatomic) IBOutlet UITextField *MotherName;
@property (weak, nonatomic) IBOutlet UITextField *FatherName;
@property (weak, nonatomic) IBOutlet UITextField *BirthStreetNumber;
@property (weak, nonatomic) IBOutlet UITextField *BirthStreetName;
@property (weak, nonatomic) IBOutlet UITextField *BirthCity;
@property (weak, nonatomic) IBOutlet UITextField *BirthState;
@property (weak, nonatomic) IBOutlet UITextField *BirthZipcode;
@property (weak, nonatomic) IBOutlet UITextField *CurrentStreetNumber;
@property (weak, nonatomic) IBOutlet UITextField *CurrentStreetName;
@property (weak, nonatomic) IBOutlet UITextField *CurrentCity;
@property (weak, nonatomic) IBOutlet UITextField *CurrentState;
@property (weak, nonatomic) IBOutlet UITextField *CurrentZipcode;
@property (weak, nonatomic) IBOutlet UISegmentedControl *Gender;
@property (weak, nonatomic) IBOutlet UITextField *middleName;

@property (weak, nonatomic) IBOutlet UIDatePicker *DateOfBirth;

@property (nonatomic, strong) NSMutableArray *patients;

@property (weak, nonatomic) IBOutlet UIButton *EditButton;
- (IBAction)EditAction:(id)sender;

@end
