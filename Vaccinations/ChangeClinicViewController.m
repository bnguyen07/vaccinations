//
//  ChangeClinicViewController.m
//  Vaccinations
//
//  Created by Subash Dantuluri on 11/5/13.
//  Copyright (c) 2013 Subash Dantuluri. All rights reserved.
//

#import "ChangeClinicViewController.h"


#define kGetUrlToChangeClinic @"http://192.168.1.72/changePhysicianClinic.php"

#define kclinic @"clinic"
#define kphysician_id @"physician_id"

@interface ChangeClinicViewController ()

@end

@implementation ChangeClinicViewController


@synthesize clinic_new;
@synthesize reenterNew_Clinic;
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
    
    NSLog(@"Inside Change Clinic, physician ID: %@", physician);
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelAction:(id)sender {
  [self.view removeFromSuperview];
}
- (IBAction)changeClinic:(id)sender {
    
    
    
    if (![[clinic_new text] isEqualToString: [reenterNew_Clinic text]]) {
        UIAlertView *clinicNotMatch = [[UIAlertView alloc] initWithTitle:@"Clinic Not Match" message:@"The new clinices don't match." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [clinicNotMatch show];
    } else {
        
        //Brian: Nov 06, 2013
        //Create Register Patient User post string
        
        NSMutableString *postString = [NSMutableString stringWithString:kGetUrlToChangeClinic];
        [postString appendString:[NSString stringWithFormat:@"?%@=%@", kphysician_id, physician]];
        
        [postString appendString:[NSString stringWithFormat:@"&%@=%@", kclinic, [clinic_new text]]];
  
        NSLog(@"%@",postString);
        
        [postString setString:[postString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        NSURL *url = [NSURL URLWithString:postString];
        NSLog(@"This is the GET string for the Change Physician clinic: %@", url);
        
        NSString *postResult = [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        
        if ([postResult isEqualToString:@"Cannot update your clinic! Please check your inputs."]) {
            UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:@"Fail to create Username" message:postResult delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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
