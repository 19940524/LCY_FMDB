//
//  UserDB.m
//  FMDB
//
//  Created by GuoBIn on 15/7/20.
//  Copyright (c) 2015年 自强不息. All rights reserved.
//

#import "UserDB.h"
#import <FMDB.h>

#define dataBasePath [[(NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)) lastObject]stringByAppendingPathComponent:dataBaseName]
#define dataBaseName @"GuoBIn.sqlite"

// 把userDB设计成一个单例类
static UserDB *instnce;

@implementation UserDB

// 把userDB设计成一个单例类
+ (id)shareInstance
{
    if (instnce == nil) {
        instnce = [[[self class] alloc] init];
    }
    return instnce;
}

// 创建用户表
- (void)createTable
{
    // 文件路径
    NSString *filePath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@",dataBaseName];
    NSLog(@"文件路径 == %@",filePath);
    
    FMDatabase *db = [FMDatabase databaseWithPath:dataBasePath];
    
    if ([db open]) {
        if (![db tableExists:@"user"]) {
            if ([db executeUpdate:@"CREATE TABLE user (Serial text primary key,dataText text)"]) {
                NSLog(@"创建表成功");
            }else{
                NSLog(@"创建表失败");
            }
        } else {
            NSLog(@"表已经存在");
        }
    } else{
        NSLog(@"打开表失败");
    }
    [db close];
    
}

// 添加用户
- (void)addData:(NSArray *)dataArray
{
    NSString *serial   = [dataArray objectAtIndex:0];
    NSString *dataText = [dataArray objectAtIndex:1];
    
    FMDatabase *db = [FMDatabase databaseWithPath:dataBasePath];
    if ([db open]) {
    // 插入数据
    [db executeUpdate:@"insert into user (Serial,DataText) values(?,?)",serial,dataText,nil];
    }
    [db close];
}

// 查询用户
- (NSArray *)findDatas
{
    NSMutableArray *users = [NSMutableArray array];
    FMDatabase *db = [FMDatabase databaseWithPath:dataBasePath];
    if ([db open]) {
        // 获取所有数据
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM user"];
        while ([rs next]) {
            NSString *serial = [rs stringForColumn:@"Serial"];
            NSString *dataText = [rs stringForColumn:@"DataText"];
            
            [users addObject:@[serial,dataText]];
        }
        [rs close];
    }
    [db close];
    return users;
}

- (void)deleteRowData:(NSArray *)array
{
    NSString *serial = [array objectAtIndex:0];
    NSString *dataText = [array objectAtIndex:1];
    
    FMDatabase *db = [FMDatabase databaseWithPath:dataBasePath];
    if ([db open]) {
        // 删除某个数据
        BOOL rs = [db executeUpdate:@"DELETE FROM user WHERE Serial = ? and DataText = ?",serial,dataText];
        
        if (rs) {
            NSLog(@"删除成功");
        } else {
            NSLog(@"删除失败");
        }
    }
    [db close];
}

// 清空表中的数据：
- (void)clearTableData
{
    FMDatabase *db = [FMDatabase databaseWithPath:dataBasePath];
    if ([db open]) {
        // 清除全部数据
        [db executeUpdate:@"DELETE FROM user"];
    }
    [db close];
}

// 更新数据
- (void)executeUpdate:(NSArray *)array
{
    NSString *serial = [array objectAtIndex:0];
    NSString *dataText = [array objectAtIndex:1];
    
    FMDatabase *db = [FMDatabase databaseWithPath:dataBasePath];
    if ([db open]) {
        [db executeUpdate:@"UPDATE user SET DataText = ? WHERE Serial = ?",dataText,serial];
    }
    [db close];
    
}

@end
