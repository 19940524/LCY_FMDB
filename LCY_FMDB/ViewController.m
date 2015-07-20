//
//  ViewController.m
//  LCY_FMDB
//
//  Created by GuoBIn on 15/7/20.
//  Copyright (c) 2015年 自强不息. All rights reserved.
//

#import "ViewController.h"
#import "UserDB.h"
#import "AddViewController.h"

@interface ViewController ()
{
    IBOutlet UITableView *_tableView;
    NSArray *listArray;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UserDB shareInstance] createTable];
    
}
- (IBAction)itemAction:(UIBarButtonItem *)sender {
    switch (sender.tag) {
        case 100:
            [[UserDB shareInstance] clearTableData];
            listArray = [[UserDB shareInstance] findDatas];
            [_tableView reloadData];
            self.title = @"";
            
            break;
        case 101:
            [self.navigationController pushViewController:[[AddViewController alloc] init] animated:YES];
            break;
            
        default:
            break;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        
    }
    
    cell.textLabel.text = [listArray[indexPath.row] objectAtIndex:1];
    cell.detailTextLabel.text = [listArray[indexPath.row] objectAtIndex:0];
    cell.selectionStyle = NO;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{

    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[UserDB shareInstance] deleteRowData:listArray[indexPath.row]];
        
        NSMutableArray *array = [NSMutableArray arrayWithArray:listArray];
        [array removeObjectAtIndex:indexPath.row];
        listArray = array;
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        if (listArray.count == 0) {
            self.title = @"";
        }
        
    }
} 

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    listArray = [[UserDB shareInstance] findDatas];
    [_tableView reloadData];
    if (listArray.count != 0) {
        self.title = @"左滑显示删除";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
