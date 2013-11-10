//
//  VaccinesDueListVC.m
//  Vaccinations
//
//  Created by Subash Dantuluri on 10/22/13.
//  Copyright (c) 2013 Subash Dantuluri. All rights reserved.
//

#import "VaccinesDueListVC.h"



//Brian
//Nov 08, 2013
#define kGetUrlForVaccinations @"http://localhost/list_vaccine_not_taken.php"
#define kpatient_id @"patient_id"

@interface VaccinesDueListVC ()

@end

@implementation VaccinesDueListVC

@synthesize childName;

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
   
    //Brian: Nov 09, 2013
    //Make sure that the patientID is right
    NSLog(@"Patient ID is: %@", _patientID );
    
    self.navigationItem.title = self.childName;

    //Brian
	//Nov 1, 2013
    [self runUrlRequest];

}


//Brian
// Fix Nov 09, 2013
-(void) runUrlRequest {
    
    NSMutableString *getString = [NSMutableString stringWithString:kGetUrlForVaccinations];
    [getString appendString:[NSString stringWithFormat:@"?%@=\"%@\"", kpatient_id, _patientID]];
    
    NSLog(@"This is the GET string for the Login function: %@", getString);
    [getString setString:[getString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSURL *url = [NSURL URLWithString:getString];
    NSLog(@"This is the GET string for the Login function: %@", url);
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSError *error;
    if (data) {
        _vaccinesDue = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        NSLog(@"%@", _vaccinesDue);
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Error" message:@"data is nil. Check the connection. Turn off firewall." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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
    return _vaccinesDue.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    //Subash
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    UILabel* label1 = (UILabel *)[cell viewWithTag:100];  //    Main Label
    UILabel* label2 = (UILabel *)[cell viewWithTag:101];  //    Sub Label
    

    //Brian
    //Fix Nov 09, 2013
    label1.text = [[_vaccinesDue objectAtIndex:indexPath.row] objectForKey:@"vaccine_id"];
    //[label1 setTextColor:[UIColor redColor]];
    label2.text = [[_vaccinesDue objectAtIndex:indexPath.row] objectForKey:@"vaccine_name"];
    //[label2 setTextColor:[UIColor redColor]];
    
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
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UILabel* label1 = (UILabel *)[cell viewWithTag:100];
    UILabel* label2 = (UILabel *)[cell viewWithTag:101];
    
    NSDate* curDate = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
	df.dateStyle = NSDateFormatterMediumStyle;
    NSString* dateString = [NSString stringWithFormat:@"%@",[df stringFromDate:curDate]];
    
    NSString* alertString;
    alertString = [NSString stringWithFormat:@"%@\n %@\n Given date: %@",label1.text, label2.text, dateString];
    
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Give Vaccination?" message:alertString delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    [alert show];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0)
    {
        NSLog(@"YES");
        
        //write the code to update vaccionations due database
        //run url request
        
        [_myTableView reloadData];
        
    }
    else
    {
        NSLog(@"NO");
    }
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
