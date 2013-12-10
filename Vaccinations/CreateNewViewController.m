//
//  CreateNewViewController.m
//  Vaccinations
//
//  Created by Subash Dantuluri on 10/19/13.
//  Copyright (c) 2013 Subash Dantuluri. All rights reserved.
//

#import "CreateNewViewController.h"
#import "AppDelegate.h"

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
    self.title = @"Create New";
    kPostURL = [[NSString alloc] initWithFormat:@"http://%@/postNewRecord_new.php", gServerIp];
    NSLog(@"kPostURL: %@", kPostURL); //For Debugging
    NSLog(@"Physician got from Login page: %@", _physician_id); // For Debugging
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





//Brian: call the URL to post the data
- (IBAction)createNewRecord:(id)sender {
    
    if ([_lastName.text  isEqual: @""] || [_firstName.text  isEqual: @""] || [_motherMaidenName.text  isEqual: @""]) {
        UIAlertView *requiredFieldsNotFilledAlert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please fill in required fields." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [requiredFieldsNotFilledAlert show];
        return;
    } else {
        
        NSMutableString *postString = [NSMutableString stringWithString:kPostURL];
        [postString appendString:[NSString stringWithFormat:@"?%@=%@", kfirst_name, [_firstName.text capitalizedString]]];
        
        [postString appendString:[NSString stringWithFormat:@"&%@=%@", klast_name, [_lastName.text capitalizedString]]];
        
        [postString appendString:[NSString stringWithFormat:@"&%@=%@", kmiddle_name, [_middleName.text capitalizedString]]];
        
        //Convert date to string
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        NSString *birthDate = [dateFormat stringFromDate:[_dateOfBirth date]];
        
        
        NSDate *now = [NSDate date]; // Get the current date
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *dateComponents = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:now];
        NSInteger currentYear=[dateComponents year];

        // Checking year is not in the future
        NSDateComponents *dateCompFromDatePicker = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:[_dateOfBirth date]];
        NSInteger yearFromDatePicker=[dateCompFromDatePicker year];
        if (yearFromDatePicker > currentYear) {
            UIAlertView *dateAlert = [[UIAlertView alloc] initWithTitle:@"Date Error" message:@"Birth year is in the future!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [dateAlert show];
            return;
        }
        
        // Check month is not in future
        NSInteger currentMonth=[dateComponents month];
        NSInteger monthFromDatePicker=[dateCompFromDatePicker month];
        if (monthFromDatePicker > currentMonth) {
            UIAlertView *dateAlert = [[UIAlertView alloc] initWithTitle:@"Date Error" message:@"Birth month is in the future!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [dateAlert show];
            return;
        } else if (monthFromDatePicker == currentMonth){
            // Check day is not in future
            NSInteger dayFromDatePicker=[dateCompFromDatePicker day];
            NSInteger currentDay=[dateComponents day];
            if (dayFromDatePicker > currentDay) {
                UIAlertView *dateAlert = [[UIAlertView alloc] initWithTitle:@"Date Error" message:@"Birth day is in the future!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [dateAlert show];
                return;
            }
        }

        
        
        
        
        
        
        [postString appendString:[NSString stringWithFormat:@"&%@=%@", kbirthdate, birthDate]];
        
        
         _genderString = [[NSString alloc] initWithString:[_gender titleForSegmentAtIndex:[_gender selectedSegmentIndex]]];
        
        [postString appendString:[NSString stringWithFormat:@"&%@=%@", kgender, [[_genderString substringToIndex:1] capitalizedString]]];
        
        [postString appendString:[NSString stringWithFormat:@"&%@=%@", kmother_name, [_motherName.text capitalizedString]]];
        
        [postString appendString:[NSString stringWithFormat:@"&%@=%@", kmother_maiden_name, [_motherMaidenName.text capitalizedString]]];
        
        [postString appendString:[NSString stringWithFormat:@"&%@=%@", kfather_name, [_fatherName.text capitalizedString]]];
        [postString appendString:[NSString stringWithFormat:@"&%@=%@", kPOB_street_number, _streetNumberPOB.text]];
        [postString appendString:[NSString stringWithFormat:@"&%@=%@", kPOB_street_name, [_streetNamePOB.text capitalizedString]]];
        [postString appendString:[NSString stringWithFormat:@"&%@=%@", kPOB_city, [_cityPOB.text capitalizedString]]];
        [postString appendString:[NSString stringWithFormat:@"&%@=%@", kPOB_state, [_statePOB.text uppercaseString]]];
        [postString appendString:[NSString stringWithFormat:@"&%@=%@", kPOB_zipcode, _zipcodePOB.text]];
        
        [postString appendString:[NSString stringWithFormat:@"&%@=%@", kcurrent_street_number, _currentStreetNumber.text]];
        [postString appendString:[NSString stringWithFormat:@"&%@=%@", kcurrent_street_name, [_currentStreetName.text capitalizedString]]];
        [postString appendString:[NSString stringWithFormat:@"&%@=%@", kcurrent_city, [_currentCity.text capitalizedString]]];
        [postString appendString:[NSString stringWithFormat:@"&%@=%@", kcurrent_state, [_currentState.text uppercaseString]]];
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
    
    NSLog(@"Call the post method"); //For Debugging
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





- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ((textField == _currentStreetNumber) ||  (textField == _currentStreetName) ||  (textField == _currentCity) ||  (textField == _currentState) ||  (textField == _currentZipcode)) {
        CGRect frame = self.view.frame;
        frame.origin.y -= 100;
        self.view.frame = frame;
    }
}





- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ((textField == _currentStreetNumber) ||  (textField == _currentStreetName) ||  (textField == _currentCity) ||  (textField == _currentState) ||  (textField == _currentZipcode)) {
        CGRect frame = self.view.frame;
        frame.origin.y += 100;
        self.view.frame = frame;
    }
}

@end
