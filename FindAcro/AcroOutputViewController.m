//
//  AcroOutputViewController.m
//  FindAcro
//
//  Created by Vishal Sharma on 3/14/17.
//  Copyright © 2017 Vishal Sharma. All rights reserved.
//

#import "AcroOutputViewController.h"
#import "AcroFinderModel.h"
#import "MBProgressHUD.h"

@interface AcroOutputViewController ()
@property (weak, nonatomic) IBOutlet UITableView *outputTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *acroSearchBar;
@property (strong, nonatomic) AcroFinderModel *finderModel;
@end

@implementation AcroOutputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _finderModel = [[AcroFinderModel alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Table Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_outputArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [_outputArray objectAtIndex:indexPath.row];
    cell.backgroundView = [UIView new];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.selectedBackgroundView = [UIView new];
    return cell;
}

#pragma mark Searchbar Delegates

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [_acroSearchBar resignFirstResponder];
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [_finderModel searchAcronym:_acroSearchBar.text completion:^(BOOL success, NSArray *outputArray) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if (success) {
                    _outputArray = outputArray;
                    [_outputTableView reloadData];
                    
                }
            });
        }];
    });
}

@end
