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
#define kGetUrlForPatients @"http://localhost/searchPatients.php"


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
    
    //Brian: Temp fix Nov 1
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
      NSURL *url = [NSURL URLWithString:kGetUrlForPatients];
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
    }
    else {
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
    }
}
@end
