//
//  HomeVC.h
//  HomeVC
//
//  Created by BWF-HHW on 16/4/28.
//  Copyright © 2016年 BWF. All rights reserved.
//

#import "MessageVC.h"

#import "PropertyViewController.h"
#import "DelegateViewController.h"
#import "SingletonViewController.h"
//#import "ExternViewController.h"
#import "DefaultViewController.h"
#import "BlockViewController.h"
#import "NotificationViewController.h"

@interface MessageVC()

@property (nonatomic, retain) NSArray *dataArray;

@end


@implementation MessageVC

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"传值";
    
    
    self.dataArray = @[@"属性传值", @"代理传值", @"单例传值", @"extern传值", @"NSUserDefaults传值", @"Block传值", @"通知传值"];


}

#pragma mark - Methods

- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    
    
}

#pragma mark - Table view

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}




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
//            ExternViewController *externVC = [[ExternViewController alloc] init];
//            [self.navigationController pushViewController:externVC animated:YES];
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
