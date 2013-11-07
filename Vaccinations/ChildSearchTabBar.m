//
//  ChildSearchTabBar.m
//  Vaccinations
//
//  Created by Brian Nguyen on 11/7/13.
//  Copyright (c) 2013 Subash Dantuluri. All rights reserved.
//

#import "ChildSearchTabBar.h"

@interface ChildSearchTabBar ()

@end

@implementation ChildSearchTabBar

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
    NSLog(@"Physician is: %@", _physician);
    NSLog(@"Physician's clinic: %@", [_physician[0] objectForKey:@"clinic"]);
    NSLog(@"Physician's password: %@", [_physician[1] objectForKey:@"password"]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
