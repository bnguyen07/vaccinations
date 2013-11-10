//
//  QRScanViewController.m
//  Vaccinations
//
//  Created by Subash Dantuluri on 10/19/13.
//  Copyright (c) 2013 Subash Dantuluri. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import <ZXCapture.h>
#import <ZXResult.h>
#import "QRScanViewController.h"
#import "ChildDetailsViewController.h"

@interface QRScanViewController ()
@property ZXCapture *capture;
@property (strong, nonatomic) NSString *scannedResult;
@property BOOL gotResult;
@end

#pragma mark - QR Scanner View Controller Methods

@implementation QRScanViewController

@synthesize changePwdVC;
@synthesize changeClinicVC;

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
   
   self.title = @"QR Scan";
   self.gotResult = NO;
   
   if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
   {
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"No camera detected on this device" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
      [alert show];
   }
    
    
    NSLog(@"Physician got from Login page: %@", _physician_id);
    

}

- (void)viewWillAppear:(BOOL)animated {
   [super viewWillAppear:animated];
   
   self.capture = [[ZXCapture alloc] init];
   self.capture.delegate = self;
   self.capture.rotation = 90.0f;
   
   // Use the back camera
   self.capture.camera = self.capture.back;
   
   self.capture.layer.frame = _imageView.bounds;
   [_imageView.layer addSublayer:self.capture.layer];
   //   [self.view bringSubviewToFront:self.resultLabel];
}

- (void)didReceiveMemoryWarning
{
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
   
   
}


- (IBAction)logoutAction:(id)sender {
    //[self dismissViewControllerAnimated:YES completion:nil];
    
    NSString *actionSheetTitle = @"Options"; //Action Sheet Title
    NSString *other1 = @"Change Password";
    NSString *other2 = @"Change Clinic";
    NSString *other3 = @"Logout";
    NSString *cancelTitle = @"Cancel";
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:actionSheetTitle
                                  delegate:self
                                  cancelButtonTitle:cancelTitle
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:other1, other2, other3, nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        changePwdVC = (ChangePasswordViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"ChangePasswordViewController"];
        [changePwdVC setPhysician:_physician_id];
        
        changePwdVC.view.frame = CGRectMake(184, 312, 400, 400);
        [self.view addSubview:changePwdVC.view];
    }
    else if (buttonIndex == 1) {
        changeClinicVC = (ChangeClinicViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"ChangeClinicViewController"];
        changeClinicVC.view.frame = CGRectMake(184, 312, 400, 400);
        [self.view addSubview:changeClinicVC.view];
    }
    else if (buttonIndex == 2) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)rescanPressed:(id)sender {
   self.gotResult = NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
   return toInterfaceOrientation == UIInterfaceOrientationPortrait;
}

#pragma mark - Private Methods

- (NSString*)displayForResult:(ZXResult*)result {
   NSString *formatString;
   switch (result.barcodeFormat) {
      case kBarcodeFormatQRCode:
         formatString = @"QR Code";
         break;
      default:
         formatString = @"Unknown";
   }
   
   return [NSString stringWithFormat:@"Scanned! Format: %@ Contents:%@", formatString, result.text];
}

#pragma mark - ZXCaptureDelegate Methods

- (void)captureResult:(ZXCapture*)capture result:(ZXResult*)result {
   if (result && ![self gotResult]) {
      // We got a result. Display information about the result onscreen.
      self.gotResult = YES;
      self.scannedResult = result.text;
      NSLog(@"scanned result: %@", result.text);
      
      // Vibrate
      AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
      [self performSegueWithIdentifier:@"QR2CD" sender:nil];
   }
}

- (void)captureSize:(ZXCapture*)capture width:(NSNumber*)width height:(NSNumber*)height {
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
   if ([segue.identifier isEqualToString:@"QR2CD"]) {
      ChildDetailsViewController *cd = [segue destinationViewController];
      [cd setRecordID:[NSString stringWithFormat:@"%@", self.scannedResult]];
   }

}


@end