//
//  UIImage+YeasImage.m
//  YeasVideoImages_Example
//
//  Created by  on 2021/5/10.
//  Copyright © 2021 huoda1237. All rights reserved.
//

#import "UIImage+YeasImage.h"

@implementation UIImage (YeasImage)

+ (UIImage *)imageWithNameString:(NSString *)name {
    UIImage *image = [UIImage imageNamed:name];
    return image;
}

@end
