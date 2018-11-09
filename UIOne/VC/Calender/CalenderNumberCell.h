//
//  CalenderNumberCell.h
//  UIOne
//
//  Created by SaturdayNight on 2018/1/26.
//  Copyright © 2018年 SaturdayNight. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalenderNumberCell : UICollectionViewCell

@property (nonatomic,strong) UILabel *lbTitle;

-(void)makeSelected:(BOOL)ifSelected;

@end
