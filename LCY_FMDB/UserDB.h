//
//  UserDB.h
//  FMDB
//
//  Created by GuoBIn on 15/7/20.
//  Copyright (c) 2015年 自强不息. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDB : NSObject

// 把userDB设计成一个单例类
+ (id)shareInstance;

// 创建用户表
- (void)createTable;

// 添加用户
- (void)addData:(NSArray *)dataArray;

// 查询用户
- (NSArray *)findDatas;

// 删除一行数据
- (void)deleteRowData:(NSArray *)array;

// 清空表中的数据：
- (void)clearTableData;

// 更新数据
- (void)executeUpdate:(NSArray *)array;

@end
