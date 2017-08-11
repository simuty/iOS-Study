//
//  RootTableViewController.m
//  TestPassByValue
//
//  Created by BWF on  .
//  Copyright (c) 2016年 BWF. All rights reserved.
//

#import "RootTableViewController.h"

#import "PropertyViewController.h"
#import "DelegateViewController.h"
#import "SingletonViewController.h"
#import "ExternViewController.h"
#import "DefaultViewController.h"
#import "BlockViewController.h"
#import "NotificationViewController.h"

static NSString *cellIdentifier = @"cell";

@interface RootTableViewController ()
{
    NSArray *dataArray;
}

@end

@implementation RootTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"传值方式";
    
    dataArray = @[@"属性传值", @"代理传值", @"单例传值", @"extern传值", @"NSUserDefaults传值", @"Block传值", @"通知传值"];
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    // Configure the cell...
    cell.textLabel.text = dataArray[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0://property传值
        {
            PropertyViewController *propertyVC = [[PropertyViewController alloc] init];
            [self.navigationController pushViewController:propertyVC animated:YES];
            break;
        }
        case 1://Delegate
        {
            DelegateViewController *delegateVC = [[DelegateViewController alloc] init];
            [self.navigationController pushViewController:delegateVC animated:YES];
            break;
        }
        case 2://Singleton
        {
            SingletonViewController *singletonVC = [[SingletonViewController alloc] init];
            [self.navigationController pushViewController:singletonVC animated:YES];
            break;
        }
        case 3:
        {
            ExternViewController *externVC = [[ExternViewController alloc] init];
            [self.navigationController pushViewController:externVC animated:YES];
            break;
        }
        case 4:
        {
            DefaultViewController *defaultVC = [[DefaultViewController alloc] init];
            [self.navigationController pushViewController:defaultVC animated:YES];
            break;
        }
        case 5:
        {
            BlockViewController *blockVC = [[BlockViewController alloc] init];
            [self.navigationController pushViewController:blockVC animated:YES];
            break;
        }
        case 6:
        {
            NotificationViewController *notificationVC = [[NotificationViewController alloc] init];
            [self.navigationController pushViewController:notificationVC animated:YES];
            break;
        }
        default:
            break;
    }
}


@end
