//
//  RegisterParentViewController.m
//  Vaccinations
//
//  Created by Brian Nguyen on 11/4/13.
//  Copyright (c) 2013 Subash Dantuluri. All rights reserved.
//

#import "RegisterParentViewController.h"

#define kPostURL @"http://localhost/postNewPatientUser.php"
#define kuser_id @"user_id"
#define kpassword @"password"
#define kemail @"email"
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
        
        //Brian: Nov 06, 2013
        //Create Register Patient User post string
        
        NSMutableString *postString = [NSMutableString stringWithString:kPostURL];
        [postString appendString:[NSString stringWithFormat:@"?%@=%@", kuser_id, [_ParentUsername text]]];
        
        [postString appendString:[NSString stringWithFormat:@"&%@=%@", kpassword, [_ParentPassword text]]];
        [postString appendString:[NSString stringWithFormat:@"&%@=%@", kemail, [_ParentEmail text]]];
        
        NSLog(@"%@",postString);
        
        [postString setString:[postString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:postString]];
        [request setHTTPMethod:@"POST"];
        
        _postNewPatientUser = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
        
        NSLog(@"%@", _postNewPatientUser);

                
    }
    
    
    
}
@end
