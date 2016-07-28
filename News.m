//
//  News.m
//  Demo_CoreData
//
//  Created by wangpanpan on 16/7/25.
//  Copyright © 2016年 wangpanpan. All rights reserved.
//

#import "News.h"

@implementation News

// Insert code here to add functionality to your managed object subclass
- (id)initWithDictionary:(NSDictionary*)dictionary
{
    self = [super init];
    if (self) {
        self.newsid = [dictionary objectForKey:@"id"];
        self.title = [dictionary objectForKey:@"title"];
        self.descr = [dictionary objectForKey:@"descr"];
        self.imgurl = [dictionary objectForKey:@"imgurl"];
        self.islook = @"0";//0未查看1已查看
    }
    return self;
}


@end
