//
//  CoreDataManager.m
//  Demo_CoreData
//
//  Created by wangpanpan on 16/7/26.
//  Copyright © 2016年 wangpanpan. All rights reserved.
//

#import "CoreDataManager.h"

@implementation CoreDataManager
#pragma mark - Core Data Stack -

- (NSManagedObjectContext *)managedObjectContext{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *model = [[NSBundle mainBundle]URLForResource:@"NewsModel" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc]initWithContentsOfURL:model];
    return _managedObjectModel;
}
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentDirectory]URLByAppendingPathComponent:@"NewsModel.sqlite"];
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"创业邦------%@--%@",error,[error userInfo]);
        abort();
    }
    return _persistentStoreCoordinator;
}
#pragma mark - Application's Documents Directory -
-(NSURL *)applicationDocumentDirectory{
    return [[[NSFileManager defaultManager]URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask]lastObject];
}

//插入数据
- (void)insertCoreData:(NSMutableArray *)dataArray{
    NSManagedObjectContext *context = [self managedObjectContext];
    for (News *info in dataArray) {
        News *newsInfo = [NSEntityDescription insertNewObjectForEntityForName:TableName inManagedObjectContext:context];
        newsInfo.newsid = info.newsid;
        newsInfo.title = info.title;
        newsInfo.imgurl = info.imgurl;
        newsInfo.descr = info.descr;
        newsInfo.islook = info.islook;
        
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"不能保存：-------%@",[error localizedDescription]);
        }
    }
}
//查询
- (NSMutableArray *)selectData:(int)pageSize andOffset:(int)currentPage{
    NSManagedObjectContext *context = [self managedObjectContext];
    //限定查询结果的数量 setFetchLimit
    //查询的偏移量 setFetchOffset
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    
    [fetchRequest setFetchLimit:pageSize];
    [fetchRequest setFetchOffset:currentPage];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:TableName inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    NSMutableArray *resultArray = [NSMutableArray array];
    
    for (News *info in fetchedObjects) {
        NSLog(@"id:%@", info.newsid);
        NSLog(@"title:%@", info.title);

        [resultArray addObject:info];
    }
    return resultArray;
}

//删除
- (void)delegateData{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:TableName inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setIncludesPropertyValues:NO];
    [request setEntity:entity];
    NSError *error = nil;
    NSArray *datas = [context executeFetchRequest:request error:&error];
    if (!error && datas &&[datas count]) {
        for (NSManagedObject *obj in datas) {
            [context deleteObject:obj];
        }
        if (![context save:&error]) {
            NSLog(@"error:%@",error);
        }
    }
}
//更新
- (void)updateData:(NSString *)newsId withIsLook:(NSString *)isLook{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"newsid like[cd] %@",newsId];
    
    //首先建立一个request
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:[NSEntityDescription entityForName:TableName inManagedObjectContext:context]];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    //这里获取到的是一个数组，你需要取出你要更新的那个obj
    NSArray *result = [context executeFetchRequest:request error:&error];
    for (News *info in result) {
        info.islook = isLook;
    }
    //保存
    if ([context save:&error]) {
        //更新成功
        NSLog(@"更新成功");

    }
}

@end
