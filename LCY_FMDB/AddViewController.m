//
//  AddViewController.m
//  LCY_FMDB
//
//  Created by GuoBIn on 15/7/20.
//  Copyright (c) 2015年 自强不息. All rights reserved.
//

#import "AddViewController.h"
#import "UserDB.h"

@interface AddViewController ()
{

    IBOutlet UITextField *key;
    IBOutlet UITextField *text;
}
@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)addAction:(UIButton *)sender {
    if ([key.text isEqualToString:@""] || [text.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"有参数为输入" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
    } else {
        [[UserDB shareInstance] addData:@[key.text,text.text]];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
