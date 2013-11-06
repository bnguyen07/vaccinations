//
//  SearchViewController.m
//  Vaccinations
//
//  Created by Subash Dantuluri on 10/19/13.
//  Copyright (c) 2013 Subash Dantuluri. All rights reserved.
//

#import "SearchViewController.h"
#import "ChildListViewController.h"


//Change localhost to your IP address in order to using Ipad
#define kGetUrlForPatients @"http://localhost/searchPatients.php"

@interface SearchViewController ()

@end

@implementation SearchViewController

@synthesize changePwdVC;
@synthesize changeClinicVC;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) runUrlRequest {
  //Brian
   NSURL *url = [NSURL URLWithString:kGetUrlForPatients];
   NSData *data = [NSData dataWithContentsOfURL:url];
  NSError *error;
   _patients = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
   //NSLog(@"%@", _patients);
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"Search";
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //Subash
    //sending all patients to TVC
    if ([segue.identifier isEqualToString:@"Search2ChildListVC"]) {
        
       UINavigationController* nav =  segue.destinationViewController;
        ChildListViewController* childList = (ChildListViewController *)[nav.viewControllers objectAtIndex:0];
        [childList setArrayList:_selectedPatient];
        
//        //Brian
//        [childList setArrayList:_selectedPatient];
        
    }
    
}

- (IBAction)searchAction:(id)sender {
    
    [self runUrlRequest];
    _selectedPatient = [[NSMutableArray alloc] initWithObjects:nil];

    
//    //Brian
//    [_lastName resignFirstResponder];
//    [_firstName resignFirstResponder];
//    [_motherMaidenName resignFirstResponder];
//    
//    
//    [self runUrlRequest];
    
    
    for (int i = 0 ; i < _patients.count; i++) {
        if ([_lastName.text  isEqual: @""] || [_firstName.text  isEqual: @""] || [_motherMaidenName.text  isEqual: @""]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please fill in required fields." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        
       // NSLog(@"Last name from database: %@", [[_patients objectAtIndex:i] objectForKey:@"last_name"]);
        //NSLog(@"Last name from UI: %@", _lastName.text);
        //NSLog(@"First name from database: %@", [[_patients objectAtIndex:i] objectForKey:@"first_name"]);
        //NSLog(@"First name from UI: %@", _firstName.text);
        //NSLog(@"Mothers name from database: %@", [[_patients objectAtIndex:i] objectForKey:@"mother_maiden_name"]);
        //NSLog(@"Mothers name from UI: %@", _motherMaidenName.text);
//        NSLog(@"Last name from UI type : %@", [_lastName.text class]);
        if (([_lastName.text caseInsensitiveCompare: [[_patients objectAtIndex:i] objectForKey:@"last_name"]] == NSOrderedSame) &&
            ([_firstName.text caseInsensitiveCompare: [[_patients objectAtIndex:i] objectForKey:@"first_name"]] == NSOrderedSame) &&
            ([_motherMaidenName.text  caseInsensitiveCompare:  [[_patients objectAtIndex:i] objectForKey:@"mothers_maiden_name"]] == NSOrderedSame))
        {
            [_selectedPatient addObject:[_patients objectAtIndex:i]];
       }
    }
    
    
    
    //Brian
    //Alert no found search
    if (_selectedPatient.count == 0) {
        UIAlertView * noFoundAlert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:@"Patient does not exist" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [noFoundAlert show];
        return;
    }
    
    
    NSLog(@"This is the selected patients list: %@", _selectedPatient);
    //Subash
    [self performSegueWithIdentifier:@"Search2ChildListVC" sender:self];
    
}
@end
