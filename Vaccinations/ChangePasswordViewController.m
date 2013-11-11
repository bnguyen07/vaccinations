//
//  ChangePasswordViewController.m
//  Vaccinations
//
//  Created by Subash Dantuluri on 11/5/13.
//  Copyright (c) 2013 Subash Dantuluri. All rights reserved.
//

#import "ChangePasswordViewController.h"

#define kGetUrlToChangePassword @"http://192.168.1.72/changePhysicianPassword.php"

#define kuser_id @"user_id"

#define kpassword @"password"

#define knew_password @"new_password"


@interface ChangePasswordViewController ()

@end

@implementation ChangePasswordViewController

@synthesize Password_Current;
@synthesize Password_New;
@synthesize Reenter_NewPassword;
@synthesize physician;
@synthesize user_id;




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
    
    NSLog(@"Inside Change Password, physician ID: %@", physician);
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelAction:(id)sender {
    [self.view removeFromSuperview];
}

- (IBAction)changePassword:(id)sender {
    
    if (![[Password_New text] isEqualToString: [Reenter_NewPassword text]]) {
        UIAlertView *passwordNotMatch = [[UIAlertView alloc] initWithTitle:@"Passwords Not Match" message:@"The new passwords don't match." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [passwordNotMatch show];
    } else if ([[Password_Current text] isEqualToString:[Password_New text]]) {
        UIAlertView *passwordHasBeenUsed = [[UIAlertView alloc] initWithTitle:@"Passwords Has Been Used" message:@"The new password is the same as the current password." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [passwordHasBeenUsed show];
    }else{
    
        //Brian: Nov 06, 2013
        //Create Register Patient User post string
        
        NSMutableString *postString = [NSMutableString stringWithString:kGetUrlToChangePassword];
        [postString appendString:[NSString stringWithFormat:@"?%@=%@", kuser_id, user_id]];
        
        [postString appendString:[NSString stringWithFormat:@"&%@=%@", kpassword, [Password_Current text]]];
        [postString appendString:[NSString stringWithFormat:@"&%@=%@", knew_password, [Password_New text]]];
        
        NSLog(@"%@",postString);
        
        [postString setString:[postString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        NSURL *url = [NSURL URLWithString:postString];
        NSLog(@"This is the GET string for the Change Physician password: %@", url);
        
        NSString *postResult = [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        
        if ([postResult isEqualToString:@"Cannot update your password! Please check your inputs."]) {
            UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:@"Fail to update password" message:postResult delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [failAlert show];
            return;
        } else {
            
            
            UIAlertView *successfulAlert = [[UIAlertView alloc] initWithTitle:@"Successfully!" message:postResult delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [successfulAlert show];
            return;
            
            NSLog(@"Username has been created successfully.");
        }
        

    }
}

    


@end
