//
//  CreateNewViewController.m
//  Vaccinations
//
//  Created by Subash Dantuluri on 10/19/13.
//  Copyright (c) 2013 Subash Dantuluri. All rights reserved.
//

#import "CreateNewViewController.h"

//Brian : create new record function
// October 23, 2013
//Change localhost to your IP address in order to using Ipad
#define kPostURL @"http://localhost/postNewRecord.php"

#define kpatient_id @"patient_id"

#define kfirst_name @"first_name"

#define klast_name @"last_name"

#define kmiddle_name @"middle_name"

#define kbirthdate @"birthdate"

#define kgender  @"gender"

#define kmother_maiden_name @"mother_maiden_name"

#define kmother_name  @"mother_name"

#define kfather_name @"father_name"

#define kPOB_street_number @"POB_street_number"

#define kPOB_street_name @"POB_street_name"

#define kPOB_city @"POB_city"

#define kPOB_state @"POB_state"

#define kPOB_zipcode  @"POB_zipcode"

#define kcurrent_street_number  @"current_street_number"

#define kcurrent_street_name @"current_street_name"

#define kcurrent_city @"current_city"

#define kcurrent_state @"current_state"

#define kcurrent_zipcode  @"current_zipcode "

@interface CreateNewViewController ()

@end

@implementation CreateNewViewController

@synthesize changePwdVC;
@synthesize changeClinicVC;
@synthesize birthString, genderString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"Create New";
    
    if (_gender.selectedSegmentIndex == 0) {
        genderString = @"M";
    }
    else {
        genderString = @"F";
    }
    
    NSDate* birthDate = _dateOfBirth.date;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
	df.dateStyle = NSDateFormatterMediumStyle;
    self.birthString = [NSString stringWithFormat:@"%@",[df stringFromDate:birthDate]];
    
    
     NSLog(@"Physician got from Login page: %@", _physician_id);
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Brian: create s string connection for post
-(void) postNewRecord:(NSString*) patientID withFirstName:(NSString*) firstName
         withLastName:(NSString*) lastName withMiddleName:(NSString*) middleName
        withBirthDate:(NSString*) birthdate withGender:(NSString*) gender withMotherMaidenName:(NSString*) motherMaidenName
       withMotherName:(NSString*) motherName withFatherName:(NSString*) fatherName
withBirthStreetNumber:(NSString*) birthStreetNumber withBirthStreetName:(NSString*) birthStreetName
        withBirthCity:(NSString*) birthCity withBirthState:(NSString*) birthState
     withBirthZipcode:(NSString*) birthZipcode withCurrentStreetNumber:(NSString*) currentStreetNumber
withCurrentStreetName:(NSString*) currentStreetName withCurrentCity:(NSString*) currentCity
     withCurrentState:(NSString*) currentState withCurrentZipcode:(NSString*) currentZipcode {
    
    
    NSMutableString *postString = [NSMutableString stringWithString:kPostURL];
    [postString appendString:[NSString stringWithFormat:@"?%@=%@", kpatient_id, patientID]];
    
    [postString appendString:[NSString stringWithFormat:@"&%@=%@", kfirst_name, firstName]];
    
    [postString appendString:[NSString stringWithFormat:@"&%@=%@", klast_name, lastName]];
    
    [postString appendString:[NSString stringWithFormat:@"&%@=%@", kmiddle_name, middleName]];
    
    //Convert date to string
    [postString appendString:[NSString stringWithFormat:@"&%@=%@", kbirthdate, birthdate]];
    
    [postString appendString:[NSString stringWithFormat:@"&%@=%@", kgender, gender]];
    [postString appendString:[NSString stringWithFormat:@"&%@=%@", kmother_maiden_name, motherMaidenName]];
    [postString appendString:[NSString stringWithFormat:@"&%@=%@", kmother_name, motherName]];
    [postString appendString:[NSString stringWithFormat:@"&%@=%@", kfather_name, fatherName]];
    [postString appendString:[NSString stringWithFormat:@"&%@=%@", kPOB_street_number, birthStreetNumber]];
    [postString appendString:[NSString stringWithFormat:@"&%@=%@", kPOB_street_name, birthStreetName]];
    [postString appendString:[NSString stringWithFormat:@"&%@=%@", kPOB_city, birthCity]];
    [postString appendString:[NSString stringWithFormat:@"&%@=%@", kPOB_state, birthState]];
    [postString appendString:[NSString stringWithFormat:@"&%@=%@", kPOB_zipcode, birthZipcode]];
    [postString appendString:[NSString stringWithFormat:@"&%@=%@", kcurrent_street_number, currentStreetNumber]];
    [postString appendString:[NSString stringWithFormat:@"&%@=%@", kcurrent_street_name, currentStreetName]];
    [postString appendString:[NSString stringWithFormat:@"&%@=%@", kcurrent_city, currentCity]];
    [postString appendString:[NSString stringWithFormat:@"&%@=%@", kcurrent_state, currentState]];
    [postString appendString:[NSString stringWithFormat:@"&%@=%@", kcurrent_zipcode, currentZipcode]];
    
    NSLog(@"%@",postString);
    [postString setString:[postString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:postString]];
    [request setHTTPMethod:@"POST"];
    
    _postNewRecord = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    
    NSLog(@"%@", _postNewRecord);
    
}


//Brian: call the URL to post the data
- (IBAction)createNewRecord:(id)sender {
    
    if ([_recordID.text  isEqual: @""] || [_lastName.text  isEqual: @""] || [_firstName.text  isEqual: @""] || [_motherMaidenName.text  isEqual: @""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please fill in required fields." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    } else {
        
        [self postNewRecord:_recordID.text withFirstName:_firstName.text withLastName:_lastName.text withMiddleName:_middleName.text withBirthDate:self.birthString withGender:genderString withMotherMaidenName:_motherMaidenName.text withMotherName:_motherName.text withFatherName:_fatherName.text withBirthStreetNumber:_streetNumberPOB.text withBirthStreetName:_streetNamePOB.text withBirthCity:_cityPOB.text withBirthState:_statePOB.text withBirthZipcode:_zipcodePOB.text withCurrentStreetNumber:_currentStreetNumber.text withCurrentStreetName:_currentStreetName.text withCurrentCity:_currentCity.text withCurrentState:_currentState.text withCurrentZipcode:_currentZipcode.text];
        
    
        

        UIAlertView *successfulAlert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"New patient record is successfully created" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [successfulAlert show];
        return;

    
    }
    
    
    
    NSLog(@"Call the post method");
    
    
}



//Brian: To dismisss keyboard
- (IBAction)dimissKeyboard:(id)sender {
    [_recordID resignFirstResponder];
    [_lastName resignFirstResponder];
    [_firstName resignFirstResponder];
    [_middleName resignFirstResponder];
    [_motherName resignFirstResponder];
    [_motherMaidenName resignFirstResponder];
    [_fatherName resignFirstResponder];
    [_streetNumberPOB resignFirstResponder];
    [_streetNamePOB resignFirstResponder];
    [_cityPOB resignFirstResponder];
    [_statePOB resignFirstResponder];
    [_zipcodePOB resignFirstResponder];
    [_currentStreetNumber resignFirstResponder];
    [_currentStreetName resignFirstResponder];
    [_currentCity resignFirstResponder];
    [_currentState resignFirstResponder];
    [_currentZipcode resignFirstResponder];
    
}

- (IBAction)datePickerAction:(id)sender {
    NSDate* birthDate = ((UIDatePicker*)sender).date;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
	df.dateStyle = NSDateFormatterMediumStyle;
    self.birthString = [NSString stringWithFormat:@"%@",[df stringFromDate:birthDate]];
}

- (IBAction)segmentGenderAction:(id)sender {
    UISegmentedControl* seg = (UISegmentedControl*)sender;
    
    if (seg.selectedSegmentIndex == 0) {
        genderString = @"M";
    }
    else {
        genderString = @"F";
    }
}




- (IBAction)logoutAction:(id)sender {
    //[self dismissViewControllerAnimated:YES completion:nil];
    
    NSString *actionSheetTitle = @"Options"; //Action Sheet Title
    NSString *other1 = @"Change Password";
    NSString *other2 = @"Change Clinic";
    NSString *other3 = @"Logout";
    NSString *cancelTitle = @"Cancel";
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:actionSheetTitle
                                  delegate:self
                                  cancelButtonTitle:cancelTitle
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:other1, other2, other3, nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        changePwdVC = (ChangePasswordViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"ChangePasswordViewController"];
        changePwdVC.view.frame = CGRectMake(184, 312, 400, 400);
        [self.view addSubview:changePwdVC.view];
    }
    else if (buttonIndex == 1) {
        changeClinicVC = (ChangeClinicViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"ChangeClinicViewController"];
        changeClinicVC.view.frame = CGRectMake(184, 312, 400, 400);
        [self.view addSubview:changeClinicVC.view];
        
    }
    else if (buttonIndex == 2) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
