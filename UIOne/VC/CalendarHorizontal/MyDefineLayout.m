//
//  MyDefineLayout.m
//  UIOne
//
//  Created by Tony Stark on 2018/11/12.
//  Copyright © 2018年 SaturdayNight. All rights reserved.
//

#import "MyDefineLayout.h"

@interface MyDefineLayout ()

@property (nonatomic,assign) CGFloat lastProposedContentOffset;

@end

@implementation MyDefineLayout

//- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
//    return YES;
//}
//
//-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
//    NSArray *array = [super layoutAttributesForElementsInRect:rect];
//
//    return array;
//}
//
//- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
//
//    //1. 获取UICollectionView停止的时候的可视范围
//    CGRect rangeFrame;
//    rangeFrame.size = self.collectionView.frame.size;
//    rangeFrame.origin = proposedContentOffset;
//
//    NSArray *array = [self layoutAttributesForElementsInRect:rangeFrame];
//
//    //2. 计算在可视范围的距离中心线最近的Item
//    CGFloat minCenterX = CGFLOAT_MAX;
//    CGFloat collectionCenterX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
//    for (UICollectionViewLayoutAttributes *attrs in array) {
//        if(ABS(attrs.center.x - collectionCenterX) < ABS(minCenterX)){
//            minCenterX = attrs.center.x - collectionCenterX;
//        }
//    }
//
//    //3. 补回ContentOffset，则正好将Item居中显示
//    CGFloat proposedX = proposedContentOffset.x + minCenterX;
//    // 滑动一屏时的偏移量
//    CGFloat mainScreenBounds = [UIScreen mainScreen].bounds.size.width + 10;
//    // 正向滑动仅滑动一屏
//    if (proposedX - self.lastProposedContentOffset >= mainScreenBounds) {
//        proposedX = mainScreenBounds + self.lastProposedContentOffset;
//    }
//    // 反向滑动仅滑动一屏
//    if (proposedX - self.lastProposedContentOffset <= -mainScreenBounds) {
//        proposedX = -mainScreenBounds + self.lastProposedContentOffset;
//    }
//
//    self.lastProposedContentOffset = proposedX;
//
//    CGPoint finialProposedContentOffset = CGPointMake(proposedX, proposedContentOffset.y);
//    return finialProposedContentOffset;
//}

@end
