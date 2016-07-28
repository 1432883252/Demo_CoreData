//
//  News.h
//  Demo_CoreData
//
//  Created by wangpanpan on 16/7/25.
//  Copyright © 2016年 wangpanpan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface News : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
- (id)initWithDictionary:(NSDictionary*)dictionary;

@end

NS_ASSUME_NONNULL_END

#import "News+CoreDataProperties.h"
