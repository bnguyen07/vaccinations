//
//  VaccinesDueListVC.m
//  Vaccinations
//
//  Created by Subash Dantuluri on 10/22/13.
//  Copyright (c) 2013 Subash Dantuluri. All rights reserved.
//

#import "VaccinesDueListVC.h"
#import "AppDelegate.h"



//Brian
//Nov 08, 2013
//#define kGetUrlForVaccinesNotTaken @"http://192.168.1.72/list_vaccine_not_taken.php"
//#define kGetUrlForCreateNewVaccination @"http://192.168.1.72/postNewVaccination.php"
NSString *kGetUrlForVaccinesNotTaken;
NSString *kGetUrlForCreateNewVaccination;

#define kvaccination_id @"vaccination_id"
#define kpatient_id @"patient_id"
#define kvaccine_id @"vaccine_id"
#define kphysician_id @"physician_id"
#define kdate_taken @"date_taken"

@interface VaccinesDueListVC (){
   BOOL confirm;
}

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
   confirm = NO;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
   
    //Brian: Nov 09, 2013
    //Make sure that the patientID is right
    NSLog(@"Patient ID is: %@", _patientID );
    NSLog(@"Physician ID in Vaccines Due: %@", _physician_id);
   kGetUrlForCreateNewVaccination = [[NSString alloc] initWithFormat:@"http://%@/postNewVaccination.php", gServerIp];
   kGetUrlForVaccinesNotTaken = [[NSString alloc] initWithFormat:@"http://%@/list_vaccine_not_taken.php", gServerIp];
   NSLog(@"kGetUrlForCreateNewVaccination: %@", kGetUrlForCreateNewVaccination);
   NSLog(@"kGetUrlForVaccinesNotTaken: %@", kGetUrlForVaccinesNotTaken);
   
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    _dateTakenAsString = [dateFormat stringFromDate:[NSDate date]];
    NSLog(@"Current date is: %@", _dateTakenAsString);
    
    
    self.navigationItem.title = self.childName;
    
    _selectedVaccineMainLabel = [[NSString alloc] init];
    _selectedVaccineSubLabel = [[NSString alloc] init];

    [self runUrlRequest];

}


//Brian
// Fix Nov 09, 2013
-(void) runUrlRequest {
    
    NSMutableString *getString = [NSMutableString stringWithString:kGetUrlForVaccinesNotTaken];
    [getString appendString:[NSString stringWithFormat:@"?%@=%@", kpatient_id, _patientID]];
    
    NSLog(@"This is the GET string for the Login function: %@", getString);
    [getString setString:[getString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSURL *url = [NSURL URLWithString:getString];
    NSLog(@"This is the GET string for the Login function: %@", url);
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSError *error;
    if (data) {
        _vaccinesDue = [[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error]mutableCopy];
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
    return [_vaccinesDue count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    //Brian
    //Fix Nov 09, 2013
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    UILabel* label1 = (UILabel *)[cell viewWithTag:100];  //    Main Label
    UILabel* label2 = (UILabel *)[cell viewWithTag:101];  //    Sub Label
    
    label1.text = [[_vaccinesDue objectAtIndex:indexPath.row] objectForKey:@"vaccine_id"];
    //[label1 setTextColor:[UIColor redColor]];
    label2.text = [[_vaccinesDue objectAtIndex:indexPath.row] objectForKey:@"vaccine_name"];
    //[label2 setTextColor:[UIColor redColor]];
    
    return cell;
}




 //Subash
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UILabel* label1 = (UILabel *)[cell viewWithTag:100];
    UILabel* label2 = (UILabel *)[cell viewWithTag:101];
    
    _selectedVaccineMainLabel = label1.text;
    _selectedVaccineSubLabel = label2.text;
   
   if (superUser) {
      NSString* alertString;
      alertString = [NSString stringWithFormat:@"Clinic: %@\n %@\n %@\n Given date: %@", clinicName, _selectedVaccineMainLabel, _selectedVaccineSubLabel, _dateTakenAsString];
      
       _deletedRow = indexPath.row;

      UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Give Vaccination?" message:alertString delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
      [alert show];
   
      [tableView deselectRowAtIndexPath:indexPath animated:NO];
      
      /*
      if (confirm) {
         confirm = NO;
         // Delete from underlying data source first!
         [self.vaccinesDue removeObjectAtIndex:indexPath.row];
         [tableView beginUpdates];
         [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
         [tableView endUpdates];
         [tableView reloadData];
      }
       */
   }
   return;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0)
    {
        NSLog(@"NO or OK");
    } else {
        NSLog(@"YES");

        //Brian: Nov 09, 2013
        // To generate the random vaccination id
        NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        int lengthOfString = 7;
        
        NSMutableString *randomString = [NSMutableString stringWithCapacity: lengthOfString];
        
        for (int i=0; i<lengthOfString; i++) {
            [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
        }
        
        NSLog(@"Random String is: %@", randomString);
        // return randomString with length of 7
        
        
        //Create Edit post string
        NSMutableString *postString = [NSMutableString stringWithString:kGetUrlForCreateNewVaccination];
        [postString appendString:[NSString stringWithFormat:@"?%@=%@", kvaccination_id, randomString]];
        [postString appendString:[NSString stringWithFormat:@"&%@=%@", kpatient_id, _patientID]];
        [postString appendString:[NSString stringWithFormat:@"&%@=%@", kvaccine_id, _selectedVaccineMainLabel]];
        [postString appendString:[NSString stringWithFormat:@"&%@=%@", kphysician_id, _physician_id]];
        [postString appendString:[NSString stringWithFormat:@"&%@=%@", kdate_taken, _dateTakenAsString]];
        
        NSLog(@"%@",postString);
        [postString setString:[postString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        NSURL *url = [NSURL URLWithString:postString];
        NSLog(@"This is the POST string for creating new Vaccination: %@", url);
        
        NSString *postResult = [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        
        if ([postResult isEqualToString:@"Cannot create new vaccination. Please check your connection or firewall."]) {
            UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:@"Fail to record the vaccination." message:postResult delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [failAlert show];
        } else {
            
            UIAlertView *successfulAlert = [[UIAlertView alloc] initWithTitle:@"Successful!" message:postResult delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [successfulAlert show];
            NSLog(@"Create new Vaccination successful.");
            
           //confirm = YES;
           
           [self.vaccinesDue removeObjectAtIndex:_deletedRow];
           [_myTableView reloadData]; 
        }
       
        //write the code to update vaccionations due database
        //run url request
        
        //[_myTableView reloadData];
    
        
    }// End of if-else
}//End of method

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
