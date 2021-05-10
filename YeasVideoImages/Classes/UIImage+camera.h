//
// Copyright (c) Huawei Technologies Co., Ltd. 2020-2028. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMedia/CoreMedia.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (camera)

+ (UIImage *)imageConvert:(CMSampleBufferRef)sampleBuffer;
+ (UIImage *)imagePixConvert:(CVPixelBufferRef)buffer;

@end

NS_ASSUME_NONNULL_END
