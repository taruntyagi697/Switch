/*
 * The MIT License (MIT)
 
 * Copyright (c) 2014 Tarun Tyagi
 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

#import <UIKit/UIKit.h>

#if !__has_feature(objc_arc)
#error Switch requires ARC. Please turn on ARC for your project or \
add -fobjc-arc flag for Switch.m file in Build Phases -> Compile Sources.
#endif

@interface Switch : UIControl
{
    
}

//Width for switch frame, should always be less than the image's width
@property(nonatomic,assign)CGFloat visibleWidth;

@property(nonatomic,assign)CGFloat visibleWidthViewImageRatio;

//Origin helps in positioning the switch, as width,height depend on image
@property(nonatomic,assign)CGPoint origin;

//Image is the switch image that contains ON-THUMB-OFF all three in it
@property(nonatomic,strong)UIImage* image;

//ON-OFF toggle boolean
@property(nonatomic,assign)BOOL on;

//Class Helper to instantiate Switch with image & expected visibleWidth of image.
//  visibleWidthViewImageRatio is a ratio between expected switch view width
//  and visible image width
+(Switch*)switchWithImage:(UIImage*)switchImage
             visibleWidth:(CGFloat)visibleWidth
visibleWidthViewImageRatio:(CGFloat)visibleWidthViewImageRatio;

@end
