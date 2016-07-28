//
//  NewsCell.h
//  WangyiNews
//
//  Created by wangpanpan on 16/7/22.
//  Copyright © 2016年 wangpanpan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News.h"
#import "UIImageView+WebCache.h"

@interface NewsCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *newsImageView;
@property (strong, nonatomic) IBOutlet UILabel *newsTitle;
@property (strong, nonatomic) IBOutlet UILabel *newsDescr;

-(void)setContent:(News*)info;

@end
