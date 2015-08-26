//
//  ScanObjcViewController.h
//  packages
//
//  Created by LOANER on 8/20/15.
//  Copyright (c) 2015 Thomas Degry. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScanDelegate <NSObject>

- (void)didScanBarCode:(NSString *)barCode;

@end

@interface ScanObjcViewController : UIViewController

@property (weak, nonatomic) id <ScanDelegate> delegate;

@end
