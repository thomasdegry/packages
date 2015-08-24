//
//  ScanObjcViewController.m
//  packages
//
//  Created by LOANER on 8/20/15.
//  Copyright (c) 2015 Thomas Degry. All rights reserved.
//

#import "ScanObjcViewController.h"
#import "MTBBarcodeScanner/MTBBarcodeScanner.h"
#import "Packages-Swift.h"

@interface ScanObjcViewController ()
@property (strong, nonatomic) MTBBarcodeScanner *scanner;
@property (strong, nonatomic) NSString *barCode; // Will hold the scanned code
@end

@implementation ScanObjcViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scanner = [[MTBBarcodeScanner alloc] initWithPreviewView:self.view];
}

- (IBAction)dismiss:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [MTBBarcodeScanner requestCameraPermissionWithSuccess:^(BOOL success) {
        if (success) {
            [self.scanner startScanningWithResultBlock:^(NSArray *codes) {
                AVMetadataMachineReadableCodeObject *code = [codes firstObject];
                
                // Store the bar code in the class
                self.barCode = code.stringValue;
                
                // Perform segue to next screen
                [self performSegueWithIdentifier:@"showDetails" sender:self];
                
                // Stop scanning to avoid memory issues
                [self.scanner stopScanning];
            }];
        } else {
            // The user denied access to the camera
        }
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDetails"]) {
        // Cast the destinationVC to a DetailsTableViewController
        DetailsTableViewController *destinationVC = (DetailsTableViewController *)segue.destinationViewController;
        
        // Set the barCode porperty on the detailsTableVC with the one declared on top
        destinationVC.barCode = self.barCode;
    }
}

@end
