//
//  VaccinesDueListVC.h
//  Vaccinations
//
//  Created by Subash Dantuluri on 10/22/13.
//  Copyright (c) 2013 Subash Dantuluri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VaccinesDueListVC : UITableViewController <UIAlertViewDelegate>
@property(nonatomic, retain) NSString* childName;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;



//Brian
//Temp Fix Nov 01, 2013
@property(nonatomic, strong) NSMutableArray * vaccinations;
@property(nonatomic, strong) NSString* patientID;



@end
