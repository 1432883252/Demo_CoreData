//
//  NewsCell.m
//  WangyiNews
//
//  Created by wangpanpan on 16/7/22.
//  Copyright © 2016年 wangpanpan. All rights reserved.
//

#import "NewsCell.h"

@implementation NewsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if (selected) {
        _newsTitle.textColor = [UIColor darkGrayColor];
    }
}

-(void)setContent:(News*)info
{
//    [_newsImageView setImageWithURL:[NSURL URLWithString:info.imgurl]];
    [_newsImageView sd_setImageWithURL:[NSURL URLWithString:info.imgurl]];
    _newsTitle.text = info.title;
    _newsDescr.text = info.descr;
    if ([info.islook isEqualToString:@"1"]) {
        _newsTitle.textColor = [UIColor darkGrayColor];
    }
}

@end
