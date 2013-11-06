//
//  ChangeClinicViewController.m
//  Vaccinations
//
//  Created by Subash Dantuluri on 11/5/13.
//  Copyright (c) 2013 Subash Dantuluri. All rights reserved.
//

#import "ChangeClinicViewController.h"

@interface ChangeClinicViewController ()

@end

@implementation ChangeClinicViewController

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

- (IBAction)cancelAction:(id)sender {
  [self.view removeFromSuperview];
}
@end
