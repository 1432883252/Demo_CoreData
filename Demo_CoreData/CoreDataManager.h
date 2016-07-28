//
//  CoreDataManager.h
//  Demo_CoreData
//
//  Created by wangpanpan on 16/7/26.
//  Copyright © 2016年 wangpanpan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "News.h"
#define  TableName @"News"
@interface CoreDataManager : NSObject
@property (nonatomic,strong)NSManagedObjectContext *managedObjectContext;
@property (nonatomic,strong)NSManagedObjectModel *managedObjectModel;
@property (nonatomic,strong)NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentDirectory;

//插入数据
- (void)insertCoreData:(NSMutableArray *)dataArray;
//查询
- (NSMutableArray *)selectData:(int)pageSize andOffset:(int)currentPage;
//删除
- (void)delegateData;
//更新
- (void)updateData:(NSString *)newsId withIsLook:(NSString *)isLook;
@end
