//
//  ViewController.h
//  Demo_CoreData
//
//  Created by wangpanpan on 16/7/22.
//  Copyright © 2016年 wangpanpan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataManager.h"

@interface ViewController : UIViewController{
    CoreDataManager *_coredataManager;
}
@property (nonatomic, strong) NSMutableArray *resultArray;


@end

