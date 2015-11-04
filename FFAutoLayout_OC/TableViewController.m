//
//  TableViewController.m
//  FFAutoLayout_OC
//
//  Created by LXF on 15/10/18.
//  Copyright © 2015年 Xiaofeng Li . All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()

@property (nonatomic, strong) NSArray *cellTitle;
@property (nonatomic, strong) NSArray *cellTargetVCName;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cellTitle = @[@"一般",@"填充",@"子项填充",@"测试"];
    self.cellTargetVCName = @[@"NormalViewController",@"FillViewController",@"ChildFillViewController",@"TestVC"];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellTitle.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.textLabel.text = self.cellTitle[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *vcClassName = self.cellTargetVCName[indexPath.row];
    
    UIViewController *targetVC = [[NSClassFromString(vcClassName) alloc]init];
    
    targetVC.title = self.cellTitle[indexPath.row];
    
    [self.navigationController pushViewController:targetVC animated:YES ];
}
@end
