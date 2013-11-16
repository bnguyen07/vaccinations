//
//  VaccineScheduleListVC.m
//  Vaccinations
//
//  Created by Subash Dantuluri on 10/22/13.
//  Copyright (c) 2013 Subash Dantuluri. All rights reserved.
//

#import "VaccineScheduleListVC.h"
#import "AppDelegate.h"

//Brian
//Nov 01, 2013
//#define kGetUrlForVaccinations @"http://192.168.1.72/searchVaccination.php/"
NSString *kGetUrlForVaccinations;
#define kpatient_id @"patient_id"


@interface VaccineScheduleListVC ()

@end

@implementation VaccineScheduleListVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"Physician ID in Vaccine Schedule: %@", _physician_id);
   kGetUrlForVaccinations = [[NSString alloc] initWithFormat:@"http://%@/searchVaccinations.php", gServerIp];
   NSLog(@"kGetUrlForVaccinations: %@", kGetUrlForVaccinations);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //Subash
    
    self.navigationItem.title = self.childName;
    
    sectionTitles = [NSArray arrayWithObjects:@"BIRTH",@"6 WEEKS",@"10 WEEKS",@"14 WEEKS",@"9-12 MONTHS",@"15-18 MONTHS", nil];
    birthMain = [NSArray arrayWithObjects:@"BCG",@"HEPB",@"OPV/OPV1", nil];
    birthSub = [NSArray arrayWithObjects:@"BACILLUS CALMETTE-GUERIN",@"HEPATITUS B",@"ORAL POLIOVIRUS (1ST DOSE)", nil];
    SixweeksMain = [NSArray arrayWithObjects:@"PENTA/PENTA1",@"PCV/PCV1",@"OPV/OPV2",@"RV/RV1", nil];
    SixweeksSub = [NSArray arrayWithObjects:@"PENTAVALENT COMBINATION (1ST DOSE)",@"PNEUMOCOCCAL CONJUGATE (1ST DOSE)",@"ORAL POLIOVIRUS (2ND DOSE)",@"ORAL ROTAVIRUS (1ST DOSE)", nil];
    TenweeksMain = [NSArray arrayWithObjects:@"PENTA/PENTA2",@"PCV/PCV2",@"OPV/OPV3",@"RV/RV2", nil];
    TenweeksSub = [NSArray arrayWithObjects:@"PENTAVALENT COMBINATION (2ND DOSE)",@"PNEUMOCOCCAL CONJUGATE (2ND DOSE)",@"ORAL POLIOVIRUS (3ND DOSE)",@"ORAL ROTAVIRUS (2ND DOSE)", nil];
    ThreemonthsMain = [NSArray arrayWithObjects:@"PENTA/PENTA3",@"PCV/PCV3",@"OPV/OPV4",@"RV/RV3", nil];
    ThreemonthsSub = [NSArray arrayWithObjects:@"PENTAVALENT COMBINATION (3RD DOSE)",@"PNEUMOCOCCAL CONJUGATE (3RD DOSE)",@"ORAL POLIOVIRUS (4TH DOSE)",@"ORAL ROTAVIRUS (3RD DOSE)", nil];
    NinemonthsMain = [NSArray arrayWithObjects:@"MR/MR1", nil];
    NinemonthsSub = [NSArray arrayWithObjects:@"MEASLES AND RUBELLA (1ST DOSE)", nil];
    OneyearMain = [NSArray arrayWithObjects:@"MR/MR2", nil];
    OneyearSub = [NSArray arrayWithObjects:@"MEASLES AND RUBELLA (2ND DOSE)", nil];
    
}


//Brian
// Temp Fix Nov 01, 2013
-(void) runUrlRequest {
    //Brian
    //Temp fix Nov 01, 2013
//    NSMutableString *postString = [NSMutableString stringWithString:kGetUrlForVaccinations];
//    [postString appendString:[NSString stringWithFormat:@"?%@=%@", kpatient_id, _patientID]];
//    NSURL *url = [NSURL URLWithString:postString];
//    NSLog(@"URL: %@", postString);
//    NSData *data = [NSData dataWithContentsOfURL:url];
//    NSError *error;
//    _vaccinations = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
//    NSLog(@"Object return: %@", _vaccinations);
    
    NSURL *url = [NSURL URLWithString:kGetUrlForVaccinations];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSError *error;
    _vaccinations = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSLog(@"Call from runUrlRequest %@", _vaccinations);
    
    
    
}

//Brian
// Temp Fix Nov 01, 2013

-(void) displayDueVaccinations {
    [self runUrlRequest];
    NSLog(@"Call from Vaccination Vaccine Schedule List %@", _vaccinations);
}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return sectionTitles.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, tableView.frame.size.width, 25)];
    [label setFont:[UIFont boldSystemFontOfSize:20]];
    NSString *string =[sectionTitles objectAtIndex:section];
    /* Section header is in 0th index... */
    [label setText:string];
    [view addSubview:label];
    [view setBackgroundColor:[UIColor colorWithRed:0 green:1 blue:0 alpha:1.0]]; //your background color...
    return view;
}

/*
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [sectionTitles objectAtIndex:section];
}
*/

/*
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return sectionTitles;
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    int numRows = 0;
    if (section == 0) {
        numRows = birthMain.count;
    }
    else if (section == 1) {
        numRows = SixweeksMain.count;
    }
    else if (section == 2) {
        numRows = TenweeksMain.count;
    }
    else if (section == 3) {
        numRows = ThreemonthsMain.count;
    }
    else if (section == 4) {
        numRows = NinemonthsMain.count;
    }
    else if (section == 5) {
        numRows = OneyearMain.count;
    }
    return numRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
   
    
    UILabel* label1 = (UILabel *)[cell viewWithTag:104];
    UILabel* label2 = (UILabel *)[cell viewWithTag:105];
    
    if (indexPath.section == 0) {
        label1.text = [birthMain objectAtIndex:indexPath.row];
        label2.text = [birthSub objectAtIndex:indexPath.row];
    }
    else if (indexPath.section == 1) {
        label1.text = [SixweeksMain objectAtIndex:indexPath.row];
        label2.text = [SixweeksSub objectAtIndex:indexPath.row];
    }
    else if (indexPath.section == 2) {
        label1.text = [TenweeksMain objectAtIndex:indexPath.row];
        label2.text = [TenweeksSub objectAtIndex:indexPath.row];
    }
    else if (indexPath.section == 3) {
        label1.text = [ThreemonthsMain objectAtIndex:indexPath.row];
        label2.text = [ThreemonthsSub objectAtIndex:indexPath.row];
    }
    else if (indexPath.section == 4) {
        label1.text = [NinemonthsMain objectAtIndex:indexPath.row];
        label2.text = [NinemonthsSub objectAtIndex:indexPath.row];
    }
    else if (indexPath.section == 5) {
        label1.text = [OneyearMain objectAtIndex:indexPath.row];
        label2.text = [OneyearSub objectAtIndex:indexPath.row];
    }
    
    
    return cell;
    
}


//Subash
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIImageView *checkmark = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"checkmark-green.png"]];
    
    if (cell.accessoryView == nil) {
        cell.accessoryView = checkmark;
    }
    else {
        cell.accessoryView = nil;
    }
    */
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
