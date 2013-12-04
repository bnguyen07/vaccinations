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
//Fix Nov 09, 2013
@property(nonatomic, strong) NSMutableArray * vaccinations;
@property(nonatomic, strong) NSString* patientID;

@property (nonatomic, strong) NSMutableArray *vaccinesDue;

@property(nonatomic, strong) NSString* selectedVaccineMainLabel;
@property(nonatomic, strong) NSString* selectedVaccineSubLabel;

@property (nonatomic, strong) NSString *physician_id;

@property (nonatomic, strong) NSString *dateTakenAsString;
@property (nonatomic, assign) int deletedRow;

@end
