//
//  ScanObjcViewController.m
//  packages
//
//  Created by LOANER on 8/20/15.
//  Copyright (c) 2015 Thomas Degry. All rights reserved.
//

#import "ScanObjcViewController.h"
#import "MTBBarcodeScanner/MTBBarcodeScanner.h"


@interface ScanObjcViewController ()
@property (strong, nonatomic) MTBBarcodeScanner *scanner;
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
                NSLog(@"Found code: %@", code.stringValue);
                [self performSegueWithIdentifier:@"showDetails" sender:self];
                
                [self.scanner stopScanning];
            }];
        } else {
            // The user denied access to the camera
        }
    }];
}

@end
