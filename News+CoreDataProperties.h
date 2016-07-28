//
//  News+CoreDataProperties.h
//  Demo_CoreData
//
//  Created by wangpanpan on 16/7/25.
//  Copyright © 2016年 wangpanpan. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "News.h"

NS_ASSUME_NONNULL_BEGIN

@interface News (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *descr;
@property (nullable, nonatomic, retain) NSString *imgurl;
@property (nullable, nonatomic, retain) NSString *islook;
@property (nullable, nonatomic, retain) NSString *newsid;
@property (nullable, nonatomic, retain) NSString *title;

@end

NS_ASSUME_NONNULL_END
