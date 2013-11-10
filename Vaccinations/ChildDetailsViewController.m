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


//Change localhost to your IP address in order to using Ipad
//Brian Nov 09, 2013
#define kChangePatientInfo @"http://localhost/changePatientInfo.php"
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
    
    
   NSLog(@"ChildDetails Record ID: %@", [self recordID]);
   
    _lastNameTF.enabled = NO;
    _firstNameTF.enabled = NO;
    _recordNumber.enabled = NO;
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
    _Gender.enabled = NO;
    _DateOfBirth.enabled = NO;
    
    //if ([[self recordID] isEqualToString:NULL]) {
    
    //Brian: Fix Nov 09, 2013
    if (childDict != NULL) {

        _patient_id.text = [childDict objectForKey:@"patient_id"];
      _lastNameTF.text = [childDict objectForKey:@"last_name"];
      _firstNameTF.text = [childDict objectForKey:@"first_name"];
        _middleName.text = [childDict objectForKey:@"middle_name"];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-mm-dd"];
        NSDate * dateOfBirth=[formatter dateFromString:[childDict objectForKey:@"birthdate"]];
        [_DateOfBirth setDate:dateOfBirth];
        
        if ([[childDict objectForKey:@"gender"] isEqualToString:@"M"]) {
            [_Gender setSelectedSegmentIndex:0];
        } else {
            [_Gender setSelectedSegmentIndex:1];
        }        
        
      _MotherMaidenName.text = [childDict objectForKey:@"mothers_maiden_name"];
        _MotherName.text = [childDict objectForKey:@"mothers_name"];
      _FatherName.text = [childDict objectForKey:@"fathers_name"];
        _BirthStreetNumber.text = [childDict objectForKey:@"POB_street_number"];
      _BirthStreetName.text = [childDict objectForKey:@"POB_street_name"];
      _BirthCity.text = [childDict objectForKey:@"POB_city"];
      _BirthState.text = [childDict objectForKey:@"POB_state"];
      _BirthZipcode.text = [childDict objectForKey:@"POB_zipcode"];
      _CurrentStreetNumber.text = [childDict objectForKey:@"current_street_number"];
      _CurrentStreetName.text = [childDict objectForKey:@"current_street_name"];
      _CurrentCity.text = [childDict objectForKey:@"current_city"];
      _CurrentState.text = [childDict objectForKey:@"current_state"];
      _CurrentZipcode.text = [childDict objectForKey:@"current_zipcode"];
        
   } else {
      NSLog(@"ChildDetails: Got Record ID. Retrieving Record");
      NSURL *url = [NSURL URLWithString:kChangePatientInfo];
      NSData *data = [NSData dataWithContentsOfURL:url];
      NSError *error;
      
      if (data) {
         self.patients = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
         NSLog(@"patients: %@", [self patients]);
         if (self.patients == NULL) {
            NSLog(@"Check the searchPatients.php file for correct DB");
         }
         
         for (int i = 0 ; i < [self.patients count]; i++) {
            if ([[self recordID] isEqual: [[self.patients objectAtIndex:i] objectForKey:@"patient_id"]]) {
               NSLog(@"Record found. Loading fields");
               _lastNameTF.text = [[self.patients objectAtIndex:i] objectForKey:@"last_name"];
               _firstNameTF.text = [[self.patients objectAtIndex:i]objectForKey:@"first_name"];
               _MotherMaidenName.text = [[self.patients objectAtIndex:i] objectForKey:@"mothers_name"];
               _FatherName.text = [[self.patients objectAtIndex:i]objectForKey:@"fathers_name"];
               _recordNumber.text = [[self.patients objectAtIndex:i] objectForKey:@"patient_id"];
               _BirthStreetNumber.text = [[self.patients objectAtIndex:i] objectForKey:@"birth_street_number"];
               _BirthStreetName.text = [[self.patients objectAtIndex:i] objectForKey:@"birth_street_name"];
               _BirthCity.text = [[self.patients objectAtIndex:i] objectForKey:@"birth_city"];
               _BirthState.text = [[self.patients objectAtIndex:i] objectForKey:@"birth_state"];
               _BirthZipcode.text = [[self.patients objectAtIndex:i] objectForKey:@"birth_zipcode"];
               _CurrentStreetNumber.text = [[self.patients objectAtIndex:i] objectForKey:@"current_street_number"];
               _CurrentStreetName.text = [[self.patients objectAtIndex:i] objectForKey:@"current_street_name"];
               _CurrentCity.text = [[self.patients objectAtIndex:i] objectForKey:@"current_city"];
               _CurrentState.text = [[self.patients objectAtIndex:i] objectForKey:@"current_state"];
               _CurrentZipcode.text = [[self.patients objectAtIndex:i] objectForKey:@"current_zipcode"];
               [self viewWillAppear:YES];
            } // end if
         } // end for
      } else {
         NSLog(@"ChildDetails: data is nil.");
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Error" message:@"data is nil. Check the IP address of the server." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
         [alert show];
      } // end if..else data
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
      NSString* childFName = [childDict objectForKey:@"first_name"];
      NSString* childLName = [childDict objectForKey:@"last_name"];
       NSString* patientID = [childDict objectForKey:@"patient_id"];
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
      
   }
}


- (IBAction)EditAction:(id)sender {
    if ([_EditButton.titleLabel.text isEqualToString:@"Edit"]) {
        
        _lastNameTF.enabled = YES;
        _firstNameTF.enabled = YES;
        _recordNumber.enabled = YES;
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
        _Gender.enabled = YES;
        _DateOfBirth.enabled = YES;
        
        [_EditButton setTitle:@"Save" forState:UIControlStateNormal];
        
    }else if([_EditButton.titleLabel.text isEqualToString:@"Save"]) {
    
        if ([[_firstNameTF text] isEqualToString:@""] || [[_lastNameTF text] isEqualToString:@""] || [[_MotherMaidenName text] isEqualToString:@""]) {
            UIAlertView *requiredFieldsAlert = [[UIAlertView alloc] initWithTitle:@"Required Fields!" message:@"Please fill all the required fields." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [requiredFieldsAlert  show];
        } else {
            
            //Brian: Nov 08, 2013
            //Create Edit Patients post string
            NSMutableString *postString = [NSMutableString stringWithString:kChangePatientInfo];
            [postString appendString:[NSString stringWithFormat:@"?%@=%@", kpatient_id, [_patient_id.text capitalizedString]]];
            
            [postString appendString:[NSString stringWithFormat:@"&%@=%@", kfirstName, [_firstNameTF.text capitalizedString]]];
            
            [postString appendString:[NSString stringWithFormat:@"&%@=%@", klastName, [_lastNameTF.text capitalizedString]]];
            
            [postString appendString:[NSString stringWithFormat:@"&%@=%@", kmiddleName, [_middleName.text capitalizedString]]];
            
            
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"YYYY-MM-DD"];
            NSString *birthDate = [dateFormat stringFromDate:[_DateOfBirth date]];
            
            [postString appendString:[NSString stringWithFormat:@"&%@=%@", kbirthdate, birthDate]];
            
            NSString *gender = [[NSString alloc] initWithString:[_Gender titleForSegmentAtIndex:[_Gender selectedSegmentIndex]]];
            [postString appendString:[NSString stringWithFormat:@"&%@=%@", kgender, [[gender substringToIndex:1] capitalizedString]]];
            [postString appendString:[NSString stringWithFormat:@"&%@=%@", kmother_name, _MotherName.text]];
            [postString appendString:[NSString stringWithFormat:@"&%@=%@", kmother_maiden_name, _MotherMaidenName.text]];
            [postString appendString:[NSString stringWithFormat:@"&%@=%@", kfather_name, _FatherName.text]];
            [postString appendString:[NSString stringWithFormat:@"&%@=%@", kbirth_street_number, _BirthStreetNumber.text]];
            [postString appendString:[NSString stringWithFormat:@"&%@=%@", kbirth_street_name, _BirthStreetName.text]];
            [postString appendString:[NSString stringWithFormat:@"&%@=%@", kbirth_city, _BirthCity.text]];
            [postString appendString:[NSString stringWithFormat:@"&%@=%@", kbirth_state, _BirthState.text]];
            [postString appendString:[NSString stringWithFormat:@"&%@=%@", kbirth_zipcode, _BirthZipcode.text]];
            [postString appendString:[NSString stringWithFormat:@"&%@=%@", kcurrent_street_number, _CurrentStreetNumber.text]];
            [postString appendString:[NSString stringWithFormat:@"&%@=%@", kcurrent_street_name, _CurrentStreetName.text]];
            [postString appendString:[NSString stringWithFormat:@"&%@=%@", kcurrent_city, _CurrentCity.text]];
            [postString appendString:[NSString stringWithFormat:@"&%@=%@", kcurrent_state, _CurrentState.text]];
            [postString appendString:[NSString stringWithFormat:@"&%@=%@", kcurrent_zipcode, _CurrentZipcode.text]];
            
            NSLog(@"%@",postString);
            [postString setString:[postString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            
            NSURL *url = [NSURL URLWithString:postString];
            NSLog(@"This is the GET string for the Edit Patient function: %@", url);
            
            NSString *postResult = [[NSString alloc] initWithContentsOfURL:url];
            
            if ([postResult isEqualToString:@"Cannot update patient's information. Please contact administration."]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail to update Patient Information." message:postResult delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            } else {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Successfully!" message:postResult delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
                
                NSLog(@"Update Paitent information successfully.");
            }
            
            
            
            _lastNameTF.enabled = NO;
            _firstNameTF.enabled = NO;
            _recordNumber.enabled = NO;
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
            _Gender.enabled = NO;
            _DateOfBirth.enabled = NO;
            
            [_EditButton setTitle:@"Edit" forState:UIControlStateNormal];
            
            
        } //End of if-else
        
    }// End Edit Patient Info
    
    
}// End of File


@end
