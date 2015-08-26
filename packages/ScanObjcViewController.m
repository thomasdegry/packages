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
                
                // Send delegate method back
                [self.delegate didScanBarCode: code.stringValue];
                
                // Stop scanning to avoid memory issues
                [self.scanner stopScanning];
                
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
        } else {
            // The user denied access to the camera
        }
    }];
}

@end
