//
//  VaccineScheduleListVC.h
//  Vaccinations
//
//  Created by Subash Dantuluri on 10/22/13.
//  Copyright (c) 2013 Subash Dantuluri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VaccineScheduleListVC : UITableViewController{
    NSArray* sectionTitles;
    NSArray* birthMain;
    NSArray* birthSub;
    NSArray* SixweeksMain;
    NSArray* SixweeksSub;
    NSArray* TenweeksMain;
    NSArray* TenweeksSub;
    NSArray* ThreemonthsMain;
    NSArray* ThreemonthsSub;
    NSArray* NinemonthsMain;
    NSArray* NinemonthsSub;
    NSArray* OneyearMain;
    NSArray* OneyearSub;
    
}
@property(nonatomic, retain) NSString* childName;



//Brian
//Temp Fix Nov 01, 2013
@property(nonatomic, strong) NSMutableArray * vaccinations;
@property(nonatomic, strong) NSString* patientID;

@property(nonatomic, strong) NSMutableArray * vaccines;
@property(nonatomic, strong) NSMutableArray * returnDates;


@end
