//
//  ViewController.m
//  Vaccinations
//
//  Created by Subash Dantuluri on 10/18/13.
//  Copyright (c) 2013 Subash Dantuluri. All rights reserved.
//

#import "ViewController.h"

//Change localhost to your IP address in order to using Ipad
#define kGetUrlForLogin @"http://localhost/login.php"
#define kuser_id @"user_id"
#define kpassword @"password"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _users = [[NSMutableArray alloc] initWithObjects: nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) getUsernameAndPassword {
    
    NSMutableString *getString = [NSMutableString stringWithString:kGetUrlForLogin];
    [getString appendString:[NSString stringWithFormat:@"?%@=\"%@\"", kuser_id, [_Username text]]];
    [getString appendString:[NSString stringWithFormat:@"&%@=\"%@\"", kpassword, [_Password text]]];
    NSLog(@"This is the GET string for the Login function: %@", getString);
    [getString setString:[getString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];

    NSURL *url = [NSURL URLWithString:getString];
    NSLog(@"This is the GET string for the Login function: %@", url);
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSError *error;
    if (data) {
        _users = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        NSLog(@"%@", _users);
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Error" message:@"data is nil. Check the connection. Turn off firewall." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}


- (IBAction)Login:(id)sender {
       
    [_Username resignFirstResponder];
    [_Password resignFirstResponder];
    [self getUsernameAndPassword];
    
    
    
    //Brian: Nov 06, 2013
    //Make the login work
    //If user type is 1 => Login to Child List Controller
    //0 => Login to Search View Controller
    

    NSLog(@"User type: %@",[[[_users lastObject] objectForKey:@"user_type"] class]);
    
    if ([[[_users lastObject] objectForKey:@"user_type"] isEqualToString:@"1"]) {
        [self performSegueWithIdentifier:@"login2ChildListController" sender:self];
    } else {
        [self performSegueWithIdentifier:@"login2childsearchtab" sender:self];
    }
    
    
    
    //Brian: Oct 20, 2013
    //Make the login work
    /*
    
    
    for (int i = 0 ; i < _users.count; i++) {
        //Brian: Oct 20, 2013
        //Require user to input all the fields
        if ([_Username.text  isEqual: @""] || [_Password.text  isEqual: @""]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:@"Please fill all the fields." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        
        
        if ([_Username.text  isEqual: [_users[i] objectForKey:@"username"]] && [_Password.text  isEqual: [_users[i] objectForKey:@"password"]]) {
            [_Username setText:@""]; //Clear the Username and Password when Users log out
            [_Password setText:@""];
            [self performSegueWithIdentifier:@"login2childsearchtab" sender:self];
            return;
        }
    }
    
    UIAlertView *invalidLogin = [[UIAlertView alloc]
                                 initWithTitle:@"Alert!"                                                            message:@"Invalid username / password"
                                    delegate:nil
                                 cancelButtonTitle:@"OK"                             otherButtonTitles:nil, nil];
    [invalidLogin show];
    return;
    */
    

   
}
- (IBAction)dismissKeyboard:(id)sender {
    [_Username resignFirstResponder];
    [_Password resignFirstResponder] ;
    
}
@end
