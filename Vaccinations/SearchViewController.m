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
#define kSearchPatiets @"http://localhost/searchPatients.php"
#define klast_name @"last_name"
#define kfirst_name @"first_name"
#define kmother_maiden_name @"mothers_maiden_name"

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


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"Search";
    
     NSLog(@"Physician got from Login page: %@", _physician);
    
    
    
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
    
    if ([[_firstName text] isEqualToString:@""] || [[_lastName text] isEqualToString:@""] || [[_motherMaidenName text] isEqualToString:@""]) {
        UIAlertView *requiredFieldsAlert = [[UIAlertView alloc] initWithTitle:@"Required Fields!" message:@"Please fill all the required fields." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [requiredFieldsAlert  show];
    } else {
        
        //Brian: Nov 08, 2013
        //Create Search Patients post string
        NSMutableString *postString = [NSMutableString stringWithString:kSearchPatiets];
        
         [postString appendString:[NSString stringWithFormat:@"?%@=%@", kfirst_name, [[_firstName text] capitalizedString]]];
        
        [postString appendString:[NSString stringWithFormat:@"&%@=%@", klast_name, [[_lastName text] capitalizedString]]];
        
        [postString appendString:[NSString stringWithFormat:@"&%@=%@", kmother_maiden_name, [[_motherMaidenName text] capitalizedString]]];
        
        [postString setString:[postString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        NSURL *url = [NSURL URLWithString:postString];
        NSLog(@"This is the GET string for the Search Patient function: %@", url);
        
        
        NSError *error;
        NSData *data = [NSData dataWithContentsOfURL:url];
        _selectedPatient = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];

        
        if (_selectedPatient.count == 0) {
            UIAlertView * noFoundAlert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:@"Patient does not exist" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [noFoundAlert show];
            return;
        }
        
    NSLog(@"This is the selected patients list: %@", _selectedPatient);
    //Subash
    [self performSegueWithIdentifier:@"Search2ChildListVC" sender:self];
    
}
    
}
@end
