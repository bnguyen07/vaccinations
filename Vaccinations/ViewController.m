//
//  ViewController.m
//  Vaccinations
//
//  Created by Subash Dantuluri on 10/18/13.
//  Copyright (c) 2013 Subash Dantuluri. All rights reserved.
//

#import "ViewController.h"
#import "ChildSearchTabBar.h"
#import "QRScanViewController.h"
#import "SearchViewController.h"
#import "CreateNewViewController.h"
#import "ScanViewController.h"
#import "ChildListViewController.h"
#import "SettingsViewController.h"
#import "AppDelegate.h"



//Change localhost to your IP address in order to using Ipad
//#define kGetUrlForLogin @"http://192.168.1.72/login.php"
NSString *kGetUrlForLogin;
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
    kGetUrlForLogin = [[NSString alloc] initWithFormat:@"http://%@/login.php", gServerIp];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) getUsernameAndPassword {
    
    //Brian: Nov 06, 2013
    //Make the login work
    //Retrieve patients or physician depend on the user and password
    //Also return a user type
    
    NSMutableString *getString = [NSMutableString stringWithString:kGetUrlForLogin];
    [getString appendString:[NSString stringWithFormat:@"?%@=%@", kuser_id, [_Username text]]];
    [getString appendString:[NSString stringWithFormat:@"&%@=%@", kpassword, [_Password text]]];
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
    
    //If user type is 1 => Login to Child List Controller
    //If user type is 0 => Login to Search View Controller
    
    if ([_Username.text  isEqual: @""] || [_Password.text  isEqual: @""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:@"Please fill in all the fields." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }

    
    [self getUsernameAndPassword]; // Connect to the database
    
    
    // For Debug purpose
    NSString *userType = [[_users lastObject] objectForKey:@"user_type"];
   NSLog(@"User type: %@",userType);
   if ([userType isEqualToString:@"0"]) {
      superUser = YES;
      NSLog(@"super user");
   } else {
      NSLog(@"user");
   } // Could be removed later
    
    
 
    if ([[[_users lastObject] objectForKey:@"user_type"] isEqualToString:@"1"]) {
        [self performSegueWithIdentifier:@"login2ChildListController" sender:self];
    } else if([[[_users lastObject] objectForKey:@"user_type"] isEqualToString:@"0"]) {
        [self performSegueWithIdentifier:@"login2childsearchtab" sender:self];
    } else {
        UIAlertView *invalidLogin = [[UIAlertView alloc] initWithTitle:@"Alert!"                                           message:@"Invalid username / password" delegate:nil cancelButtonTitle:@"OK"                             otherButtonTitles:nil, nil];
        [invalidLogin show];
        return;
    }
    
}



-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Send physician to Physician view
    if ([segue.identifier isEqualToString:@"login2childsearchtab"]) {
        ChildSearchTabBar* tabBarView = segue.destinationViewController;
        [tabBarView setPhysician:_users];
        
        //This is how to prepareForSegue for TabBarController. It's diffenent to a normal segue
        UITabBarController* childSearchTabBar =  segue.destinationViewController;
        UINavigationController* QRScanTab = [childSearchTabBar.viewControllers objectAtIndex:0];
        UINavigationController* SearchViewTab = [childSearchTabBar.viewControllers objectAtIndex:1];
        UINavigationController* CreateNewTab = [childSearchTabBar.viewControllers objectAtIndex:2];
        UINavigationController* ScanViewTab = [childSearchTabBar.viewControllers objectAtIndex:3];
        
        
        QRScanViewController* QRScanController = (QRScanViewController*)[QRScanTab.viewControllers objectAtIndex:0];
        SearchViewController* SearchController = (SearchViewController*)[SearchViewTab.viewControllers objectAtIndex:0];
        CreateNewViewController* CreateController = (CreateNewViewController*)[CreateNewTab.viewControllers objectAtIndex:0];
        ScanViewController* ScanController = (ScanViewController*)[ScanViewTab.viewControllers objectAtIndex:0];
        
        NSString* physician_id = [[NSString alloc] initWithString:[[_users firstObject] objectForKey:@"physician_id"]];
        NSString* user_id = [[NSString alloc] initWithString:[[_users lastObject] objectForKey:@"user_id"]];
        
        NSLog(@"Physician from Login: %@", physician_id);
        [QRScanController setPhysician_id:physician_id];
        [SearchController setPhysician_id:physician_id];
        [CreateController setPhysician_id:physician_id];
        [ScanController setPhysician_id:physician_id];
        
        [QRScanController setUser_id:user_id];
        [SearchController setUser_id:user_id];
        [CreateController setPhysician_user_id:user_id];
        [ScanController setUser_id:user_id];
                
        
        
    } else if([segue.identifier isEqualToString:@"login2ChildListController"]) {
        
        UINavigationController* nav =  segue.destinationViewController;
        ChildListViewController* childList = (ChildListViewController *)[nav.viewControllers objectAtIndex:0];
        NSMutableArray *patients = [[NSMutableArray alloc] initWithArray:_users];
         NSLog(@"Users are type: %@", patients.class);
        [patients removeLastObject];
        NSLog(@"Users are: %@", patients);
        [childList setArrayList:patients];
    }
    
    [_Username setText:@""];
    [_Password setText:@""];
    

}

-(IBAction)saveSettings:(UIStoryboardSegue*)segue{
   NSLog(@"serverIp = %@", gServerIp);
   if ([gServerIp isEqualToString:@""]) {
      url = @"http://localhost";
   } else {
      url = [[NSString alloc] initWithFormat:@"http://%@", gServerIp ];
   }
   NSLog(@"url = %@", url);
   kGetUrlForLogin = [[NSString alloc] initWithFormat:@"%@/login.php", url];
   NSLog(@"kGetUrlForLogin = %@", kGetUrlForLogin);
}

-(IBAction)cancel:(UIStoryboardSegue*)sender{
   
}


- (IBAction)dismissKeyboard:(id)sender {
    [_Username resignFirstResponder];
    [_Password resignFirstResponder] ;
    
}

- (IBAction)systemPreferenceBtn:(id)sender {
}
@end
