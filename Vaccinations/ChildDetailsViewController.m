//
//  ChildDetailsViewController.m
//  Vaccinations
//
//  Created by Subash Dantuluri on 10/19/13.
//  Copyright (c) 2013 Subash Dantuluri. All rights reserved.
//

#import "ChildDetailsViewController.h"
#import "VaccinesDueListVC.h"
#import "VaccineScheduleListVC.h"
#import "PatientsHistoryListVC.h"
#import "AppDelegate.h"

NSString *kChangePatientInfo;

NSString *kGetPatientDetails;

#define kpatient_id @"patient_id"
#define klastName @"last_name"
#define kfirstName @"first_name"
#define kmiddleName @"middle_name"
#define kbirthdate @"birthdate"
#define kgender @"gender"
#define kmother_maiden_name @"mothers_maiden_name"
#define kmother_name @"mothers_name"
#define kfather_name @"fathers_name"
#define kbirth_street_number @"POB_street_number"
#define kbirth_street_name @"POB_street_name"
#define kbirth_city @"POB_city"
#define kbirth_state @"POB_state"
#define kbirth_zipcode @"POB_zipcode"
#define kcurrent_street_number @"current_street_number"
#define kcurrent_street_name @"current_street_name"
#define kcurrent_city @"current_city"
#define kcurrent_state @"current_state"
#define kcurrent_zipcode @"current_zipcode"
#define kuser_id @"user_id"


@interface ChildDetailsViewController ()

@end

@implementation ChildDetailsViewController

@synthesize childDict;

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
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor whiteColor]];
    kChangePatientInfo = [[NSString alloc] initWithFormat:@"http://%@/changePatientInfo.php", gServerIp];
    
    NSLog(@"kChangePatientInfo: %@", kChangePatientInfo); // For debugging
    NSLog(@"ChildDetails Record ID: %@", [self recordID]); // For debugging
    
    
    //Nov 24, 2013 : Refresh the patient details from database
    kGetPatientDetails = [[NSString alloc] initWithFormat:@"http://%@/getPatientDetails.php", gServerIp];
    NSMutableString *getString = [NSMutableString stringWithString:kGetPatientDetails];
    [getString appendString:[NSString stringWithFormat:@"?%@=%@", kpatient_id, [childDict objectForKey:@"patient_id"]]];
    
    NSLog(@"This is the GET string for the Get patient details: %@", getString);
    [getString setString:[getString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSURL *getPatientDetailsUrl = [NSURL URLWithString:getString];
    
    NSData *patientDetails = [NSData dataWithContentsOfURL:getPatientDetailsUrl];
    NSError *error;
    if (patientDetails) {
        _childDetails = [[NSJSONSerialization JSONObjectWithData:patientDetails options:kNilOptions error:&error] objectAtIndex:0];
        NSLog(@"%@", _childDetails);
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Error" message:@"Cannot connect to databse. Please check your connection or firewall." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    // Instead of use the data sent from Child List View.
    // Now we get the data from database to make sure it's fresh as new
    
    NSLog(@"These are patient details just CREATED: %@", _childDetails);
    NSLog(@"These are patient class just CREATED: %@", [_childDetails class]);
    NSLog(@"These are patient patient_id just CREATED: %@", [_childDetails objectForKey:@"patient_id"]);
    
    
    
    _lastNameTF.enabled = NO;
    _FirstNameTextField.enabled = NO;
    _RecordNumberTextField.enabled = NO;
    _MotherMaidenName.enabled = NO;
    _MotherName.enabled = NO;
    _FatherName.enabled = NO;
    _BirthStreetNumber.enabled = NO;
    _BirthStreetName.enabled = NO;
    _BirthCity.enabled = NO;
    _BirthState.enabled = NO;
    _BirthZipcode.enabled = NO;
    _CurrentStreetNumber.enabled = NO;
    _CurrentStreetName.enabled = NO;
    _CurrentCity.enabled = NO;
    _CurrentState.enabled = NO;
    _CurrentZipcode.enabled = NO;
    _GenderSegmentedButton.enabled = NO;
    _DateOfBirth.enabled = NO;
    
    if (!superUser) {
        self.EditButton.hidden = YES;
    }
    //Brian: Fix Nov 09, 2013
    if (childDict != NULL) {
        
        _patient_id.text = [_childDetails objectForKey:@"patient_id"];
        _lastNameTF.text = [_childDetails objectForKey:@"last_name"];
        _FirstNameTextField.text = [_childDetails objectForKey:@"first_name"];
        _middleName.text = [_childDetails objectForKey:@"middle_name"];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSDate * dateOfBirth=[formatter dateFromString:[_childDetails objectForKey:@"birthdate"]];
        [_DateOfBirth setDate:dateOfBirth];
        
        if ([[_childDetails objectForKey:@"gender"] isEqualToString:@"M"]) {
            [_GenderSegmentedButton setSelectedSegmentIndex:0];
        } else {
            [_GenderSegmentedButton setSelectedSegmentIndex:1];
        }
        
        _MotherMaidenName.text = [_childDetails objectForKey:@"mothers_maiden_name"];
        _MotherName.text = [_childDetails objectForKey:@"mothers_name"];
        _FatherName.text = [_childDetails objectForKey:@"fathers_name"];
        _BirthStreetNumber.text = [_childDetails objectForKey:@"POB_street_number"];
        _BirthStreetName.text = [_childDetails objectForKey:@"POB_street_name"];
        _BirthCity.text = [_childDetails objectForKey:@"POB_city"];
        _BirthState.text = [_childDetails objectForKey:@"POB_state"];
        _BirthZipcode.text = [_childDetails objectForKey:@"POB_zipcode"];
        _CurrentStreetNumber.text = [_childDetails objectForKey:@"current_street_number"];
        _CurrentStreetName.text = [_childDetails objectForKey:@"current_street_name"];
        _CurrentCity.text = [_childDetails objectForKey:@"current_city"];
        _CurrentState.text = [_childDetails objectForKey:@"current_state"];
        _CurrentZipcode.text = [_childDetails objectForKey:@"current_zipcode"];
    } else {
        NSLog(@"ChildDetails: data is nil.");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Error" message:@"data is nil. Check the IP address of the server." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    } // end else
    
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)viewChildRecordsAction:(id)sender {
    
    [self performSegueWithIdentifier:@"CD2CRTVC" sender:self];
}





- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //subash
    //setting title on the vaccinesdetails navigation controller as the childname
    if ([segue.identifier isEqualToString:@"CD2CRTVC"]) {
        NSString* childFName = [_childDetails objectForKey:@"first_name"];
        NSString* childLName = [_childDetails objectForKey:@"last_name"];
        NSString* patientID = [_childDetails objectForKey:@"patient_id"];
        
        UITabBarController* tabC =  segue.destinationViewController;
        UINavigationController* nav = [tabC.viewControllers objectAtIndex:0];
        UINavigationController* nav1 = [tabC.viewControllers objectAtIndex:1];
        UINavigationController* nav2 = [tabC.viewControllers objectAtIndex:2];
        VaccinesDueListVC* vaccDue = (VaccinesDueListVC *)[nav.viewControllers objectAtIndex:0];
        VaccineScheduleListVC* vaccSch = (VaccineScheduleListVC *)[nav1.viewControllers objectAtIndex:0];
        PatientsHistoryListVC* patHis = (PatientsHistoryListVC *)[nav2.viewControllers objectAtIndex:0];
        
        [vaccDue setChildName:[NSString stringWithFormat:@"%@ %@",childFName, childLName]];
        [vaccSch setChildName:[NSString stringWithFormat:@"%@ %@",childFName, childLName]];
        [vaccSch setPatientID:[NSString stringWithFormat:@"%@", patientID]];
        [vaccDue setPatientID:[NSString stringWithFormat:@"%@", patientID]];
        [patHis setChildName:[NSString stringWithFormat:@"%@ %@",childFName, childLName]];
        [patHis setPatientID:[NSString stringWithFormat:@"%@", patientID]];
        
        [vaccDue setPhysician_id:_physician_id];
        [vaccSch setPhysician_id:_physician_id];
        [patHis setPhysician_id:_physician_id];
    }
}





- (IBAction)EditAction:(id)sender {
    if ([_EditButton.titleLabel.text isEqualToString:@"Edit"]) {
        
        _lastNameTF.enabled = YES;
        _FirstNameTextField.enabled = YES;
        _RecordNumberTextField.enabled = YES;
        _MotherMaidenName.enabled = YES;
        _MotherName.enabled = YES;
        _FatherName.enabled = YES;
        _BirthStreetNumber.enabled = YES;
        _BirthStreetName.enabled = YES;
        _BirthCity.enabled = YES;
        _BirthState.enabled = YES;
        _BirthZipcode.enabled = YES;
        _CurrentStreetNumber.enabled = YES;
        _CurrentStreetName.enabled = YES;
        _CurrentCity.enabled = YES;
        _CurrentState.enabled = YES;
        _CurrentZipcode.enabled = YES;
        _GenderSegmentedButton.enabled = YES;
        _DateOfBirth.enabled = YES;
        
        [_EditButton setTitle:@"Save" forState:UIControlStateNormal];
        
    }else if([_EditButton.titleLabel.text isEqualToString:@"Save"]) {
        
        
        if (![self validateFields]) { // ADD - 12/07/13
            return;
        }
        
        
        
        
        
        if ([[_FirstNameTextField text] isEqualToString:@""] || [[_lastNameTF text] isEqualToString:@""] || [[_MotherMaidenName text] isEqualToString:@""]) {
            UIAlertView *requiredFieldsAlert = [[UIAlertView alloc] initWithTitle:@"Required Fields!" message:@"Please fill all the required fields." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [requiredFieldsAlert  show];
        } else {
            
            //Brian: Nov 08, 2013
            //Create Edit Patients post string
            NSMutableString *postString = [NSMutableString stringWithString:kChangePatientInfo];
            [postString appendString:[NSString stringWithFormat:@"?%@=%@", kpatient_id, [_patient_id.text capitalizedString]]];
            
            [postString appendString:[NSString stringWithFormat:@"&%@=%@", kfirstName, [_FirstNameTextField.text capitalizedString]]];
            
            [postString appendString:[NSString stringWithFormat:@"&%@=%@", klastName, [_lastNameTF.text capitalizedString]]];
            
            [postString appendString:[NSString stringWithFormat:@"&%@=%@", kmiddleName, [_middleName.text capitalizedString]]];
            
            
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd"];
            NSString *birthDate = [dateFormat stringFromDate:[_DateOfBirth date]];
            NSDate *now = [NSDate date]; // Get the current date
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSDateComponents *dateComponents = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:now];
            NSInteger currentYear=[dateComponents year];
            
            // Checking year is not in the future
            NSDateComponents *dateCompFromDatePicker = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:[_DateOfBirth date]];
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
            
            NSString *gender = [[NSString alloc] initWithString:[_GenderSegmentedButton titleForSegmentAtIndex:[_GenderSegmentedButton selectedSegmentIndex]]];
            [postString appendString:[NSString stringWithFormat:@"&%@=%@", kgender, [[gender substringToIndex:1] capitalizedString]]];
            [postString appendString:[NSString stringWithFormat:@"&%@=%@", kmother_name, _MotherName.text]];
            [postString appendString:[NSString stringWithFormat:@"&%@=%@", kmother_maiden_name, _MotherMaidenName.text]];
            [postString appendString:[NSString stringWithFormat:@"&%@=%@", kfather_name, _FatherName.text]];
            
            
            // Check zip code of birth address
            //           NSError *error;
            //           NSRegularExpression *alpha = [NSRegularExpression regularExpressionWithPattern:@"\\D"
            //                                                                                  options:NSRegularExpressionCaseInsensitive
            //                                                                                    error:&error];
            //           NSRegularExpression *digits = [NSRegularExpression regularExpressionWithPattern:@"\\d"
            //                                                                                   options:0 error:&error];
            //           NSUInteger numberOfMatches = [alpha numberOfMatchesInString:_BirthZipcode.text options:0 range:NSMakeRange(0, [_BirthZipcode.text length])];
            //           UIAlertView *dataErrorAlert;
            //           if (numberOfMatches) {
            //              dataErrorAlert = [[UIAlertView alloc] initWithTitle:@"Input error" message:@"Check birth zip code" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            //              [dataErrorAlert show];
            //              return;
            //           }
            //
            //           numberOfMatches = [digits numberOfMatchesInString:_BirthZipcode.text options:0 range:NSMakeRange(0, [_BirthZipcode.text length])];
            //           if (numberOfMatches < 5){
            //              dataErrorAlert = [[UIAlertView alloc] initWithTitle:@"Input error" message:@"Check birth zip code" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            //              [dataErrorAlert show];
            //              return;
            //           }
            
            [postString appendString:[NSString stringWithFormat:@"&%@=%@", kbirth_zipcode, _BirthZipcode.text]];
            
            // Check street number of birth
            //           numberOfMatches = [alpha numberOfMatchesInString:_BirthStreetNumber.text
            //                                                    options:0
            //                                                      range:NSMakeRange(0, [_BirthStreetNumber.text length])];
            //           if (numberOfMatches) {
            //              dataErrorAlert = [[UIAlertView alloc] initWithTitle:@"Input error" message:@"Check birth street number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            //              [dataErrorAlert show];
            //              return;
            //           }
            
            [postString appendString:[NSString stringWithFormat:@"&%@=%@", kbirth_street_number, _BirthStreetNumber.text]];
            [postString appendString:[NSString stringWithFormat:@"&%@=%@", kbirth_street_name, _BirthStreetName.text]];
            [postString appendString:[NSString stringWithFormat:@"&%@=%@", kbirth_city, _BirthCity.text]];
            [postString appendString:[NSString stringWithFormat:@"&%@=%@", kbirth_state, _BirthState.text]];
            
            // Check street number of current
            //           numberOfMatches = [alpha numberOfMatchesInString:_CurrentStreetNumber.text
            //                                                    options:0
            //                                                      range:NSMakeRange(0, [_CurrentStreetNumber.text length])];
            //           if (numberOfMatches) {
            //              dataErrorAlert = [[UIAlertView alloc] initWithTitle:@"Input error" message:@"Check current street number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            //              [dataErrorAlert show];
            //              return;
            //           }
            
            [postString appendString:[NSString stringWithFormat:@"&%@=%@", kcurrent_street_number, _CurrentStreetNumber.text]];
            [postString appendString:[NSString stringWithFormat:@"&%@=%@", kcurrent_street_name, _CurrentStreetName.text]];
            [postString appendString:[NSString stringWithFormat:@"&%@=%@", kcurrent_city, _CurrentCity.text]];
            [postString appendString:[NSString stringWithFormat:@"&%@=%@", kcurrent_state, _CurrentState.text]];
            
            // Check zip code of current address
            //           numberOfMatches = [alpha numberOfMatchesInString:_CurrentZipcode.text
            //                                                    options:0
            //                                                      range:NSMakeRange(0, [_CurrentZipcode.text length])];
            //           if (numberOfMatches) {
            //              dataErrorAlert = [[UIAlertView alloc] initWithTitle:@"Input error" message:@"Check current zip code" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            //              [dataErrorAlert show];
            //              return;
            //           }
            //
            //           numberOfMatches = [digits numberOfMatchesInString:_CurrentZipcode.text options:0 range:NSMakeRange(0, [_CurrentZipcode.text length])];
            //           if (numberOfMatches < 5){
            //              dataErrorAlert = [[UIAlertView alloc] initWithTitle:@"Input error" message:@"Check current zip code" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            //              [dataErrorAlert show];
            //              return;
            //           }
            
            [postString appendString:[NSString stringWithFormat:@"&%@=%@", kcurrent_zipcode, _CurrentZipcode.text]];
            [postString appendString:[NSString stringWithFormat:@"&%@=%@", kuser_id, [childDict objectForKey:@"user_id"]]];
            
            NSLog(@"%@",postString);
            [postString setString:[postString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            
            NSURL *url = [NSURL URLWithString:postString];
            NSLog(@"This is the GET string for the Edit Patient function: %@", url);
            
            NSString *postResult = [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
            
            if ([postResult isEqualToString:@"Cannot update patient's information. Please contact administration."]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail to update Patient Information." message:postResult delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            } else {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Successfully!" message:postResult delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
                
                NSLog(@"Update Paitent information successfully.");
            }
            
            
            
            _lastNameTF.enabled = NO;
            _FirstNameTextField.enabled = NO;
            _RecordNumberTextField.enabled = NO;
            _MotherMaidenName.enabled = NO;
            _MotherName.enabled = NO;
            _FatherName.enabled = NO;
            _BirthStreetNumber.enabled = NO;
            _BirthStreetName.enabled = NO;
            _BirthCity.enabled = NO;
            _BirthState.enabled = NO;
            _BirthZipcode.enabled = NO;
            _CurrentStreetNumber.enabled = NO;
            _CurrentStreetName.enabled = NO;
            _CurrentCity.enabled = NO;
            _CurrentState.enabled = NO;
            _CurrentZipcode.enabled = NO;
            _GenderSegmentedButton.enabled = NO;
            _DateOfBirth.enabled = NO;
            
            [_EditButton setTitle:@"Edit" forState:UIControlStateNormal];
            
            
        }
        
    } //End of if-else
    
}// End Edit Patient Info

- (IBAction)dismissKeyboard:(id)sender {
    [_patient_id resignFirstResponder];
    [_FirstNameTextField resignFirstResponder];
    [_lastNameTF resignFirstResponder];
    [_middleName resignFirstResponder];
    [_MotherMaidenName resignFirstResponder];
    [_MotherName resignFirstResponder];
    [_FatherName resignFirstResponder];
    [_BirthStreetNumber resignFirstResponder];
    [_BirthStreetName resignFirstResponder];
    [_BirthCity resignFirstResponder];
    [_BirthState resignFirstResponder];
    [_BirthZipcode resignFirstResponder];
    [_CurrentStreetNumber resignFirstResponder];
    [_CurrentStreetName resignFirstResponder];
    [_CurrentCity resignFirstResponder];
    [_CurrentState resignFirstResponder];
    [_CurrentZipcode resignFirstResponder];
}


#pragma mark - Validation

#define REGEX_NAME @"^[A-Za-z'\\s]*$"
#define REGEX_ZIPCODE @"^\\d{5}$"
#define REGEX_PHONE @"^\\d{3}-\\d{3}-\\d{4}$"
#define REGEX_PHONE_2 @"^\\d{10}$"
#define REGEX_DIGIT @"^\\d+$"

/*
 * Validate fields
 */

-(BOOL)validateFields {
    
    NSArray *listRegexName = @[_lastNameTF, _middleName, _FirstNameTextField, _MotherMaidenName, _MotherName, _FatherName, _BirthCity, _CurrentCity];
    
    for (UITextField *field in listRegexName) {
        if ([field isEqual:_middleName]) {
            if (_middleName.text.length > 0) {
                if (![self validateField:field withRegex:REGEX_NAME]) {
                    [self showMessage:[NSString stringWithFormat:@"Fields are not valid! Letters, Space, and/or Single Quote only!"]];
                    return NO;
                }
            }
        } else if (![self validateField:field withRegex:REGEX_NAME]) {
            [self showMessage:[NSString stringWithFormat:@"Field is not valid! Letters & Space only!"]];
            return NO;
        }
    }
    
    NSArray *listRegexDigit = @[_BirthStreetNumber,_CurrentStreetNumber];
    for (UITextField *field in listRegexDigit) {
        if (![self validateField:field withRegex:REGEX_DIGIT]) {
            [self showMessage:[NSString stringWithFormat:@"Field is not valid! Number only!"]];
            return NO;
        }
    }
    
    NSArray *listZipCodes = @[_BirthZipcode,_CurrentZipcode];
    for (UITextField *field in listZipCodes) {
        if (![self validateField:field withRegex:REGEX_ZIPCODE]) {
            [self showMessage:[NSString stringWithFormat:@"Field is not valid! Format xxxxx in numbers!"]];
            return NO;
        }
    }
    
    return YES;
}


- (BOOL)validateField:(UITextField*)field withRegex:(NSString*)regex {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isValid = [predicate evaluateWithObject:field.text];
    if (!isValid) {
        invalidField = field;
        return NO;
    }
    return YES;
}

- (void)showMessage:(NSString*)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    alert.tag = 11;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 11) {
        [invalidField becomeFirstResponder];
    }
}
























@end
