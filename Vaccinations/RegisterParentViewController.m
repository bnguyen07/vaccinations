//
//  RegisterParentViewController.m
//  Vaccinations
//
//  Created by Brian Nguyen on 11/4/13.
//  Copyright (c) 2013 Subash Dantuluri. All rights reserved.
//

#import "RegisterParentViewController.h"

@interface RegisterParentViewController ()

@end

@implementation RegisterParentViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createPatientUser:(id)sender {
    
    if (![[_ParentPassword text] isEqualToString: [_ParentReenterPassword text]]) {
        UIAlertView *passwordNotMatch = [[UIAlertView alloc] initWithTitle:@"Passwords Not Match" message:@"These passwords don't match." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [passwordNotMatch show];
    } else {
        
    
    
    }
    
    
    
}
@end
