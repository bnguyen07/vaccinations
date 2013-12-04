//
//  RegisterParentViewController.m
//  Vaccinations
//
//  Created by Brian Nguyen on 11/4/13.
//  Copyright (c) 2013 Subash Dantuluri. All rights reserved.
//

#import "RegisterParentViewController.h"
#import "AppDelegate.h"

//#define kPostURL @"http://192.168.1.72/postNewPatientUser.php"
NSString *kPostURL;
#define kuser_id @"user_id"
#define kpassword @"password"
#define kemail @"email"
@interface RegisterParentViewController ()

@end

@implementation RegisterParentViewController
@synthesize popoverController;

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
    _ParentPassword.secureTextEntry = YES;
    _ParentReenterPassword.secureTextEntry = YES;
   kPostURL = [[NSString alloc] initWithFormat:@"http://%@/postNewPatientUser.php", gServerIp];
   NSLog(@"kPostURL: %@", kPostURL);
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
        
        //Brian: Nov 06, 2013
        //Create Register Patient User post string
        
        NSMutableString *postString = [NSMutableString stringWithString:kPostURL];
        [postString appendString:[NSString stringWithFormat:@"?%@=%@", kuser_id, [_ParentUsername text]]];
        
        [postString appendString:[NSString stringWithFormat:@"&%@=%@", kpassword, [_ParentPassword text]]];
        [postString appendString:[NSString stringWithFormat:@"&%@=%@", kemail, [_ParentEmail text]]];
        
        NSLog(@"%@",postString);
        
        [postString setString:[postString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        NSURL *url = [NSURL URLWithString:postString];
        NSLog(@"This is the post string from register new parent username: %@", url);
        
        NSString *postResult = [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        
        if ([postResult isEqualToString:@"The username you selected has been used. Please select another username."]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail to create Username" message:postResult delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            return;
        } else {
            
            //Brian: Nov 06, 2013
            // We need to return back to Login page from here
            //Subash will take care
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Successfully!" message:postResult delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            return;
            
            NSLog(@"Username has been created successfully.");
           
        } // End if-else
        
        
        
    }// End if-else
    
}//end of method createPatientUser

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.popoverController dismissPopoverAnimated:NO];
}

@end
