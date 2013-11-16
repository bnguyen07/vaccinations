//
//  SettingsViewController.m
//  Vaccinations
//
//  Created by Lance Truong on 15.11.13.
//  Copyright (c) 2013 Subash Dantuluri. All rights reserved.
//

#import "SettingsViewController.h"
#import "AppDelegate.h"

@interface SettingsViewController ()


@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       _ipAddress.text = @"";
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue
                sender:(id)sender{
   if ([segue.identifier isEqualToString:@"saveSettings"]) {
      if ([gServerIp isEqualToString:@""]) gServerIp = @"localhost";
      else gServerIp = self.ipAddress.text;
   }
}

@end
