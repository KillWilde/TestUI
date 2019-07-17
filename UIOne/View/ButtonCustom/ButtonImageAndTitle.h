//
//  ButtonImageAndTitle.h
//  UIOne
//
//  Created by Megatron on 2019/1/2.
//  Copyright © 2019 SaturdayNight. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ButtonImageAndTitle : UIView

@property (nonatomic,strong) UIButton *btnImage;
@property (nonatomic,strong) UIButton *btnTitle;

- (void)setImageName:(NSString *)name selectedName:(NSString *)sName title:(NSString *)title;
- (void)setImageEdge:(UIRectEdge)imageEdge imageLength:(CGFloat)iLength titleLength:(CGFloat)tLength;

@end

NS_ASSUME_NONNULL_END
