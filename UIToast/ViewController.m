//
//  ViewController.m
//  UIToast
//
//  Created by Pulkit Rohilla on 16/03/17.
//  Copyright © 2017 PulkitRohilla. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionShowToast:(id)sender {
    
    UIToastView *toast = [[UIToastView alloc] initWithText:@"Hello World!"];
    [toast show];
}

@end
