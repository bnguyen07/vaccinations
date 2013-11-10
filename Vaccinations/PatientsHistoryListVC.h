//
//  PatientsHistoryListVC.h
//  Vaccinations
//
//  Created by Subash Dantuluri on 10/22/13.
//  Copyright (c) 2013 Subash Dantuluri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PatientsHistoryListVC : UITableViewController
@property(nonatomic, retain) NSString* childName;


//Brian
//Fix Nov 10, 2013
@property(nonatomic, strong) NSMutableArray * vaccinesTaken;
@property(nonatomic, strong) NSString* patientID;

@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic, strong) NSString *physician_id;


@end
