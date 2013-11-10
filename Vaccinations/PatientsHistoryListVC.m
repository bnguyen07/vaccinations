//
//  PatientsHistoryListVC.m
//  Vaccinations
//
//  Created by Subash Dantuluri on 10/22/13.
//  Copyright (c) 2013 Subash Dantuluri. All rights reserved.
//

#import "PatientsHistoryListVC.h"


//Brian
//Temp fix Nov 01, 2013
#define kGetUrlForVaccinesTaken @"http://localhost/list_vaccine_taken.php"
#define kpatient_id @"patient_id"


@interface PatientsHistoryListVC ()

@end

@implementation PatientsHistoryListVC

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //Subash
    self.navigationItem.title = self.childName;
    NSLog(@"Physician ID in Patient History: %@", _physician_id);
    
    [self runUrlRequest];
    
    
}

//-(void)viewWillAppear:(BOOL)animated
//{
//    [self runUrlRequest];
//}
//

//Brian
// Temp Fix Nov 01, 2013
-(void) runUrlRequest {
    
    NSMutableString *getString = [NSMutableString stringWithString:kGetUrlForVaccinesTaken];
    [getString appendString:[NSString stringWithFormat:@"?%@=%@", kpatient_id, _patientID]];
    
    [getString setString:[getString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSURL *url = [NSURL URLWithString:getString];
    NSLog(@"This is URL from patient history: %@", url);
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSError *error;
    if (data) {
        _vaccinesTaken = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        NSLog(@"Vaccines taken: %@", _vaccinesTaken);
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Error" message:@"data is nil. Check your connction or firewall." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_vaccinesTaken count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        NSLog(@"Inside nil cell: ");
    }
    
    UILabel* label1 = (UILabel *)[cell viewWithTag:102];  //    Main Label
    UILabel* label2 = (UILabel *)[cell viewWithTag:103];  //    Sub Label
    
    NSLog(@"vaccine id: %@", [[_vaccinesTaken objectAtIndex:indexPath.row] objectForKey:@"vaccine_id"]);
    
    label1.text = [[_vaccinesTaken objectAtIndex:indexPath.row] objectForKey:@"vaccine_id"];
    //[label1 setTextColor:[UIColor redColor]];
    label2.text = [[_vaccinesTaken objectAtIndex:indexPath.row] objectForKey:@"date_taken"];
    //[label2 setTextColor:[UIColor redColor]];
    
    return cell;
}





//Subash
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    UILabel* label1 = (UILabel *)[cell viewWithTag:100];
//    UILabel* label2 = (UILabel *)[cell viewWithTag:101];
//    
//    _selectedVaccineMainLabel = label1.text;
//    _selectedVaccineSubLabel = label2.text;
//    
//    NSString* alertString;
//    alertString = [NSString stringWithFormat:@"%@\n %@\n Given date: %@", _selectedVaccineMainLabel, _selectedVaccineSubLabel, _dateTakenAsString];
//    
//    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Give Vaccination?" message:alertString delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
//    [alert show];
//    return;
//    
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//
//    
//}







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
