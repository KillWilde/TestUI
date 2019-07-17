//
//  HitTestTableView.m
//  UIOne
//
//  Created by Megatron on 2019/7/16.
//  Copyright © 2019 SaturdayNight. All rights reserved.
//

#import "HitTestTableView.h"

@implementation HitTestTableView

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *view = [super hitTest:point withEvent:event];
    if (view == nil) {
        BOOL find = NO;
        for (UIView *subView in self.subviews) {
            CGPoint myPoint = [subView convertPoint:point fromView:self];
            if (CGRectContainsPoint(subView.bounds, myPoint)) {
                return subView;
            }
        }
        
        if (!find) {
            for (UIView *subView in self.subviews) {
                for (UIView *sub in subView.subviews) {
                    CGPoint myPoint = [sub convertPoint:point fromView:self];
                    if (CGRectContainsPoint(sub.bounds, myPoint)) {
                        return sub;
                    }
                }
            }
        }
    }
    
    if ([view isKindOfClass:[UIButton class]]){
        for (UIView *subView in self.subviews) {
            for (UIView *sub in subView.subviews) {
                CGPoint myPoint = [sub convertPoint:point fromView:self];
                if (CGRectContainsPoint(sub.bounds, myPoint)) {
                    if ([sub isKindOfClass:[UITableView class]]) {
                        return sub;
                    }
                }
            }
        }
    }
    
    return view;
}

@end
