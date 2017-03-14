//
//  ViewController.m
//  FindAcro
//
//  Created by Vishal Sharma on 3/14/17.
//  Copyright © 2017 Vishal Sharma. All rights reserved.
//

#import "AcroInputViewController.h"
#import "AcroOutputViewController.h"
#import "AcroFinderModel.h"
#import "MBProgressHUD.h"

@interface AcroInputViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (strong, nonatomic) NSArray *outputArray;
@property (strong, nonatomic) AcroFinderModel *finderModel;
@end

@implementation AcroInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _finderModel = [[AcroFinderModel alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/**
 * Search Button Method
 */
- (IBAction)searchButtonMethod:(id)sender {
    if (_inputTextField.text.length > 0) {
        [_inputTextField resignFirstResponder];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [_finderModel searchAcronym:_inputTextField.text completion:^(BOOL success, NSArray *outputArray) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    if (success) {
                     _outputArray = outputArray;
                     [self performSegueWithIdentifier:@"AcroOutput" sender:self];
                        
                    }
                });
            }];
        });
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"AcroOutput"])
    {
        AcroOutputViewController * output = segue.destinationViewController;
        output.outputArray = _outputArray;
    }
}

@end
