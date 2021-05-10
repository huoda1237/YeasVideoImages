//
// Copyright (c) Huawei Technologies Co., Ltd. 2020-2028. All rights reserved.
//

#import "UIImage+camera.h"

@implementation UIImage (camera)

+ (UIImage *)imageConvert:(CMSampleBufferRef)sampleBuffer {
    
    CVImageBufferRef buffer;
    buffer = CMSampleBufferGetImageBuffer(sampleBuffer);

    CVPixelBufferLockBaseAddress(buffer, 0);
    uint8_t *base;
    size_t width, height, bytesPerRow;
    base = (uint8_t *)CVPixelBufferGetBaseAddress(buffer);
    width = CVPixelBufferGetWidth(buffer);
    height = CVPixelBufferGetHeight(buffer);
    bytesPerRow = CVPixelBufferGetBytesPerRow(buffer);

    CGColorSpaceRef colorSpace;
    CGContextRef cgContext;
    colorSpace = CGColorSpaceCreateDeviceRGB();
    cgContext = CGBitmapContextCreate(base, width, height, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    CGColorSpaceRelease(colorSpace);

    CGImageRef cgImage;
    UIImage *image;
    cgImage = CGBitmapContextCreateImage(cgContext);
    image = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    CGContextRelease(cgContext);

    CVPixelBufferUnlockBaseAddress(buffer, 0);
    
    return image;
}


+ (UIImage *)imagePixConvert:(CVPixelBufferRef)buffer {
    
    CVPixelBufferLockBaseAddress(buffer, 0);
    uint8_t *base;
    size_t width, height, bytesPerRow;
    base = (uint8_t *)CVPixelBufferGetBaseAddress(buffer);
    width = CVPixelBufferGetWidth(buffer);
    height = CVPixelBufferGetHeight(buffer);
    bytesPerRow = CVPixelBufferGetBytesPerRow(buffer);

    CGColorSpaceRef colorSpace;
    CGContextRef cgContext;
    colorSpace = CGColorSpaceCreateDeviceRGB();
    cgContext = CGBitmapContextCreate(base, width, height, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    CGColorSpaceRelease(colorSpace);

    CGImageRef cgImage;
    UIImage *image;
    cgImage = CGBitmapContextCreateImage(cgContext);
    image = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    CGContextRelease(cgContext);

    CVPixelBufferUnlockBaseAddress(buffer, 0);
    
    return image;
}





///////////////////

//-(CMSampleBufferRef)pixelBufferToSampleBuffer:(CVPixelBufferRef)pixelBuffer
//{
//    
//    CMSampleBufferRef sampleBuffer;
//    CMTime frameTime = CMTimeMakeWithSeconds([[NSDate date] timeIntervalSince1970], 1000000000);
//    CMSampleTimingInfo timing = {frameTime, frameTime, kCMTimeInvalid};
//    CMVideoFormatDescriptionRef videoInfo = NULL;
//    CMVideoFormatDescriptionCreateForImageBuffer(NULL, pixelBuffer, &videoInfo);
//    
//    OSStatus status = CMSampleBufferCreateForImageBuffer(kCFAllocatorDefault, pixelBuffer, true, NULL, NULL, videoInfo, &timing, &sampleBuffer);
//    if (status != noErr) {
//        NSLog(@"Failed to create sample buffer with error %zd.", status);
//    }
//    CVPixelBufferRelease(pixelBuffer);
//    if(videoInfo)
//        CFRelease(videoInfo);
//    
//    return sampleBuffer;
//}
//
//-(CVPixelBufferRef)convertVideoSmapleBufferToBGRAData:(CMSampleBufferRef)videoSample{
//    
////    CVPixelBufferRef是CVImageBufferRef的别名，两者操作几乎一致。
//    //获取CMSampleBuffer的图像地址
//    CVImageBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(videoSample);
//  //VideoToolbox解码后的图像数据并不能直接给CPU访问，需先用CVPixelBufferLockBaseAddress()锁定地址才能从主存访问，否则调用CVPixelBufferGetBaseAddressOfPlane等函数则返回NULL或无效值。值得注意的是，CVPixelBufferLockBaseAddress自身的调用并不消耗多少性能，一般情况，锁定之后，往CVPixelBuffer拷贝内存才是相对耗时的操作，比如计算内存偏移。
//    CVPixelBufferLockBaseAddress(pixelBuffer, 0);
//    //图像宽度（像素）
//    size_t pixelWidth = CVPixelBufferGetWidth(pixelBuffer);
//    //图像高度（像素）
//    size_t pixelHeight = CVPixelBufferGetHeight(pixelBuffer);
//    //获取CVImageBufferRef中的y数据
//    uint8_t *y_frame = (unsigned char *)CVPixelBufferGetBaseAddressOfPlane(pixelBuffer, 0);
//    //获取CMVImageBufferRef中的uv数据
//    uint8_t *uv_frame =(unsigned char *) CVPixelBufferGetBaseAddressOfPlane(pixelBuffer, 1);
//
//
//    // 创建一个空的32BGRA格式的CVPixelBufferRef
//    NSDictionary *pixelAttributes = @{(id)kCVPixelBufferIOSurfacePropertiesKey : @{}};
//    CVPixelBufferRef pixelBuffer1 = NULL;
//    CVReturn result = CVPixelBufferCreate(kCFAllocatorDefault,
//                                          pixelWidth,pixelHeight,kCVPixelFormatType_32BGRA,
//                                          (__bridge CFDictionaryRef)pixelAttributes,&pixelBuffer1);
//    if (result != kCVReturnSuccess) {
//        NSLog(@"Unable to create cvpixelbuffer %d", result);
//        return NULL;
//    }
//    CVPixelBufferUnlockBaseAddress(pixelBuffer, 0);
//
//    result = CVPixelBufferLockBaseAddress(pixelBuffer1, 0);
//    if (result != kCVReturnSuccess) {
//        CFRelease(pixelBuffer1);
//        NSLog(@"Failed to lock base address: %d", result);
//        return NULL;
//    }
//
//    // 得到新创建的CVPixelBufferRef中 rgb数据的首地址
//    uint8_t *rgb_data = (uint8*)CVPixelBufferGetBaseAddress(pixelBuffer1);
//
//    // 使用libyuv为rgb_data写入数据，将NV12转换为BGRA
//    int ret = NV12ToARGB(y_frame, (int)pixelWidth, uv_frame, (int)pixelWidth, rgb_data, (int)pixelWidth * 4, (int)pixelWidth, (int)pixelHeight);
//    if (ret) {
//        NSLog(@"Error converting NV12 VideoFrame to BGRA: %d", result);
//        CFRelease(pixelBuffer1);
//        return NULL;
//    }
//    CVPixelBufferUnlockBaseAddress(pixelBuffer1, 0);
//
//    return pixelBuffer1;
//}
//
//- (CVPixelBufferRef)pixelConvert:(UIImage *)image {
//    
//    CGImageRef imageRef = [image CGImage];
//    NSDictionary *options = @{
//                                  (NSString*)kCVPixelBufferCGImageCompatibilityKey : @YES,
//                                  (NSString*)kCVPixelBufferCGBitmapContextCompatibilityKey : @YES,
//                                  (NSString*)kCVPixelBufferIOSurfacePropertiesKey: [NSDictionary dictionary]
//                                  };
//        CVPixelBufferRef pxbuffer = NULL;
//        
//        CGFloat frameWidth = CGImageGetWidth(imageRef);
//        CGFloat frameHeight = CGImageGetHeight(imageRef);
//        
//        CVReturn status = CVPixelBufferCreate(kCFAllocatorDefault,
//                                              frameWidth,
//                                              frameHeight,
//                                              kCVPixelFormatType_32BGRA,
//                                              (__bridge CFDictionaryRef) options,
//                                              &pxbuffer);
//        
//        NSParameterAssert(status == kCVReturnSuccess && pxbuffer != NULL);
//        
//        CVPixelBufferLockBaseAddress(pxbuffer, 0);
//        void *pxdata = CVPixelBufferGetBaseAddress(pxbuffer);
//        NSParameterAssert(pxdata != NULL);
//        
//        CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
//        
//        CGContextRef context = CGBitmapContextCreate(pxdata,
//                                                     frameWidth,
//                                                     frameHeight,
//                                                     8,
//                                                     CVPixelBufferGetBytesPerRow(pxbuffer),
//                                                     rgbColorSpace,
//                                                     (CGBitmapInfo)kCGImageAlphaNoneSkipFirst);
//        NSParameterAssert(context);
//        CGContextConcatCTM(context, CGAffineTransformIdentity);
//        CGContextDrawImage(context, CGRectMake(0,
//                                               0,
//                                               frameWidth,
//                                               frameHeight),
//                           imageRef);
//        CGColorSpaceRelease(rgbColorSpace);
//        CGContextRelease(context);
//        
//        CVPixelBufferUnlockBaseAddress(pxbuffer, 0);
//        return pxbuffer;
//}

@end
