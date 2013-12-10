//
//  RegisterParentViewController.m
//  Vaccinations
//
//  Created by Brian Nguyen on 11/4/13.
//  Copyright (c) 2013 Subash Dantuluri. All rights reserved.
//

#import "RegisterParentViewController.h"
#import "AppDelegate.h"


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
    _PasswordTextField.secureTextEntry = YES;
    _ReenterPasswordTextField.secureTextEntry = YES;
   kPostURL = [[NSString alloc] initWithFormat:@"http://%@/postNewPatientUser.php", gServerIp];
   NSLog(@"kPostURL: %@", kPostURL);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createPatientUser:(id)sender {
    
    if([[_UsernameTextField text] isEqualToString:@"" ] ||[[_PasswordTextField text] isEqualToString:@""] || [[_EmailTextField text] isEqualToString:@""]){
        UIAlertView *requiredFieldsMissingAlert = [[UIAlertView alloc] initWithTitle:@"Required fields missing" message:@"Please fill in all the required fields." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [requiredFieldsMissingAlert show];
        return;
    
    } else if (![[_PasswordTextField text] isEqualToString: [_ReenterPasswordTextField text]]) {
        UIAlertView *passwordsNotMatch = [[UIAlertView alloc] initWithTitle:@"Passwords Not Match" message:@"These passwords don't match." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [passwordsNotMatch show];
        return;
    } else {
        
        // Dec 10, 2013
        // Validate fields
        if (![self validateFields]) {
            return;
        }
        
        //Brian: Nov 06, 2013
        //When inputs are OK, we try to connect to the database
        //Create Register Patient User post string
        
        NSMutableString *postString = [NSMutableString stringWithString:kPostURL];
        [postString appendString:[NSString stringWithFormat:@"?%@=%@", kuser_id, [_UsernameTextField text]]];
        
        [postString appendString:[NSString stringWithFormat:@"&%@=%@", kpassword, [_PasswordTextField text]]];
        [postString appendString:[NSString stringWithFormat:@"&%@=%@", kemail, [_EmailTextField text]]];
        
        NSLog(@"%@",postString); // For debugging
        
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
            
            NSLog(@"Username has been created successfully."); // For debugging
           
        } // End if-else        
        
    }// End if-else
    
}//end of method createPatientUser




- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.popoverController dismissPopoverAnimated:NO];
}



#pragma mark - Validation

#define REGEX_USERNAME @"^[A-Za-z0-9]*$"
#define REGEX_EMAIL @"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}$"

/*
 * Validate fields
 */
- (BOOL)validateFields {
    
    NSArray *listRegexUsernames = @[_UsernameTextField];
    
    for (UITextField *username in listRegexUsernames) {
        if (![self validateField:username withRegex:REGEX_USERNAME]) {
            [self showMessage:[NSString stringWithFormat:@"Username is not valid! \nLetters & Numbers only!"]];
            return NO;
        }
    }
    
    
    NSArray *listRegexEmails = @[_EmailTextField];
    
    for (UITextField *email in listRegexEmails) {
        if (![self validateField:email withRegex:REGEX_EMAIL]) {
            [self showMessage:[NSString stringWithFormat:@"Email is not valid!"]];
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





@end
