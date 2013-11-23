//
//  CreateNewViewController.m
//  Vaccinations
//
//  Created by Subash Dantuluri on 10/19/13.
//  Copyright (c) 2013 Subash Dantuluri. All rights reserved.
//

#import "CreateNewViewController.h"
#import "AppDelegate.h"

//Brian : create new record function
// October 23, 2013
//Change localhost to your IP address in order to using Ipad
//#define kPostURL @"http://192.168.1.72/postNewRecord.php"
NSString *kPostURL;

#define kpatient_id @"patient_id"

#define kfirst_name @"first_name"

#define klast_name @"last_name"

#define kmiddle_name @"middle_name"

#define kbirthdate @"birthdate"

#define kgender  @"gender"

#define kmother_maiden_name @"mothers_maiden_name"

#define kmother_name  @"mothers_name"

#define kfather_name @"fathers_name"

#define kPOB_street_number @"POB_street_number"

#define kPOB_street_name @"POB_street_name"

#define kPOB_city @"POB_city"

#define kPOB_state @"POB_state"

#define kPOB_zipcode  @"POB_zipcode"

#define kPOB_country  @"POB_country"

#define kcurrent_street_number  @"current_street_number"

#define kcurrent_street_name @"current_street_name"

#define kcurrent_city @"current_city"

#define kcurrent_state @"current_state"

#define kcurrent_zipcode  @"current_zipcode"

#define kcurrent_country  @"current_country"

#define kuser_id @"user_id"

@interface CreateNewViewController ()

@end

@implementation CreateNewViewController



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
   kPostURL = [[NSString alloc] initWithFormat:@"http://%@/postNewRecord.php", gServerIp];
   NSLog(@"kPostURL: %@", kPostURL);
    _genderString = [[NSString alloc] initWithString:[_gender titleForSegmentAtIndex:[_gender selectedSegmentIndex]]];
    
     NSLog(@"Physician got from Login page: %@", _physician_id);
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





//Brian: call the URL to post the data
- (IBAction)createNewRecord:(id)sender {
    
    if ([_recordID.text  isEqual: @""] || [_lastName.text  isEqual: @""] || [_firstName.text  isEqual: @""] || [_motherMaidenName.text  isEqual: @""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please fill in required fields." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    } else {
        
        NSMutableString *postString = [NSMutableString stringWithString:kPostURL];
        [postString appendString:[NSString stringWithFormat:@"?%@=%@", kpatient_id, _recordID.text]];
        
        [postString appendString:[NSString stringWithFormat:@"&%@=%@", kfirst_name, _firstName.text]];
        
        [postString appendString:[NSString stringWithFormat:@"&%@=%@", klast_name, _lastName.text]];
        
        [postString appendString:[NSString stringWithFormat:@"&%@=%@", kmiddle_name, _middleName.text]];
        
        //Convert date to string
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        NSString *birthDate = [dateFormat stringFromDate:[_dateOfBirth date]];
        
        [postString appendString:[NSString stringWithFormat:@"&%@=%@", kbirthdate, birthDate]];
        
        
        [postString appendString:[NSString stringWithFormat:@"&%@=%@", kgender, [[_genderString substringToIndex:1] capitalizedString]]];
        
        [postString appendString:[NSString stringWithFormat:@"&%@=%@", kmother_name, _motherName.text]];
        
        [postString appendString:[NSString stringWithFormat:@"&%@=%@", kmother_maiden_name, _motherMaidenName.text]];
        
        [postString appendString:[NSString stringWithFormat:@"&%@=%@", kfather_name, _fatherName.text]];
        [postString appendString:[NSString stringWithFormat:@"&%@=%@", kPOB_street_number, _streetNumberPOB.text]];
        [postString appendString:[NSString stringWithFormat:@"&%@=%@", kPOB_street_name, _streetNamePOB.text]];
        [postString appendString:[NSString stringWithFormat:@"&%@=%@", kPOB_city, _cityPOB.text]];
        [postString appendString:[NSString stringWithFormat:@"&%@=%@", kPOB_state, _statePOB.text]];
        [postString appendString:[NSString stringWithFormat:@"&%@=%@", kPOB_zipcode, _zipcodePOB.text]];
        
        [postString appendString:[NSString stringWithFormat:@"&%@=%@", kcurrent_street_number, _currentStreetNumber.text]];
        [postString appendString:[NSString stringWithFormat:@"&%@=%@", kcurrent_street_name, _currentStreetName.text]];
        [postString appendString:[NSString stringWithFormat:@"&%@=%@", kcurrent_city, _currentCity.text]];
        [postString appendString:[NSString stringWithFormat:@"&%@=%@", kcurrent_state, _currentState.text]];
        [postString appendString:[NSString stringWithFormat:@"&%@=%@", kcurrent_zipcode, _currentZipcode.text]];
        [postString appendString:[NSString stringWithFormat:@"&%@=%@", kuser_id, _user_id.text]];
        
        [postString setString:[postString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        NSURL *url = [NSURL URLWithString:postString];
        NSLog(@"This is the GET string for the Create New Patient function: %@", url);
        
        NSString *postResult = [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        
        if ([postResult isEqualToString:@"Cannot create new patient record. Please check your connection or firewall."]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail to create new Patient record" message:postResult delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            return;
        } else {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Successfully!" message:postResult delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            return;
            
            NSLog(@"New patient record has been created successfully.");
        }
        
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

- (IBAction)changeGender:(id)sender {
   if(self.gender.selectedSegmentIndex == 0){
		self.genderString = @"M";
	} else {
      self.genderString = @"F";
	}
}

- (IBAction)datePickerAction:(id)sender {
    NSDate* birthDate = ((UIDatePicker*)sender).date;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
	df.dateStyle = NSDateFormatterMediumStyle;
    self.birthString = [NSString stringWithFormat:@"%@",[df stringFromDate:birthDate]];
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
        _changePwdVC = (ChangePasswordViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"ChangePasswordViewController"];
         [_changePwdVC setPhysician:_physician_id];
        [_changePwdVC setUser_id:_physician_user_id];
        _changePwdVC.view.frame = CGRectMake(184, 312, 400, 400);
        [self.view addSubview:_changePwdVC.view];
       
    }
    else if (buttonIndex == 1) {
        _changeClinicVC = (ChangeClinicViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"ChangeClinicViewController"];
        [_changeClinicVC setPhysician:_physician_id];
         [_changeClinicVC setUser_id:_physician_user_id];
        _changeClinicVC.view.frame = CGRectMake(184, 312, 400, 400);
        [self.view addSubview:_changeClinicVC.view];
        
        
    }
    else if (buttonIndex == 2) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
