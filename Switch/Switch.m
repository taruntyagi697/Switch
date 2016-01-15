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

#import "Switch.h"

@interface Switch()
{
    UIImageView* imgVw;
    CGFloat gestureStartXOffset;
}

@end

@implementation Switch

+(Switch*)switchWithImage:(UIImage*)switchImage
             visibleWidth:(CGFloat)visibleWidth
visibleWidthViewImageRatio:(CGFloat)visibleWidthViewImageRatio
{
    return [[self alloc] initSwitchWithImage:switchImage visibleWidth:visibleWidth visibleWidthViewImageRatio:visibleWidthViewImageRatio];
}

-(id)initSwitchWithImage:(UIImage*)switchImage visibleWidth:(CGFloat)visibleWidth visibleWidthViewImageRatio:(CGFloat)visibleWidthViewImageRatio
{
    if(self = [super init])
    {
        _image = switchImage;
        _visibleWidth = visibleWidth;
        _visibleWidthViewImageRatio = visibleWidthViewImageRatio;
        _origin = CGPointZero;
        
        self.frame = CGRectMake(_origin.x, _origin.y,
                                _visibleWidth, self.visibleWidthViewImageRatio * _image.size.height);
        self.clipsToBounds = YES;
        
        imgVw = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:imgVw];
        
        self.image = _image;
        self.on = YES;
        
        UIPanGestureRecognizer* panRecognizer =
        [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(handlePan:)];
        [self addGestureRecognizer:panRecognizer];
        
        UITapGestureRecognizer* tapRecognizer =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [self addGestureRecognizer:tapRecognizer];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.frame = CGRectMake(self.origin.x, self.origin.y, self.visibleWidthViewImageRatio * self.visibleWidth, self.visibleWidthViewImageRatio * self.image.size.height);
    
    imgVw.bounds = CGRectMake(0.f, 0.f,
                              self.visibleWidthViewImageRatio * self.image.size.width,
                              self.visibleWidthViewImageRatio * self.image.size.height);
    imgVw.center = CGPointMake(self.on ? 0.5f * CGRectGetWidth(imgVw.bounds) : 0.f,
                               0.5f * CGRectGetHeight(self.bounds));
}

#pragma mark
#pragma mark<Property Setters>
#pragma mark

-(void)setVisibleWidth:(CGFloat)visibleWidth
{
    _visibleWidth = visibleWidth;
    [self setNeedsLayout];
}

-(void)setOrigin:(CGPoint)origin
{
    _origin = origin;
    [self setNeedsLayout];
}

-(void)setImage:(UIImage*)image
{
    _image = image;
    imgVw.image = _image;
    [self setNeedsLayout];
}

#pragma mark
#pragma mark<ON/OFF>
#pragma mark

-(void)setOn:(BOOL)on
{
    BOOL valueChanged = (_on != on);
    _on = on;
    
    [UIView animateWithDuration:0.25f delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^
     {
         self.userInteractionEnabled = NO;
         imgVw.frame = CGRectMake((_on ? 0 : -(imgVw.frame.size.width-_visibleWidth * self.visibleWidthViewImageRatio)), 0,
                                  imgVw.frame.size.width,
                                  imgVw.frame.size.height);
     }
                     completion:^(BOOL finished)
     {
         self.userInteractionEnabled = YES;
         
         if(valueChanged)
             [self sendActionsForControlEvents:UIControlEventValueChanged];
     }];
}

#pragma mark
#pragma mark<UIGestureRecognizer Handlers>
#pragma mark

-(void)handlePan:(UIPanGestureRecognizer*)panRecognizer
{
    CGFloat translationX = [panRecognizer translationInView:self].x;
    
    switch(panRecognizer.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            gestureStartXOffset = imgVw.frame.origin.x;
        }
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            if(_on && translationX < 0.0f)
            {
                imgVw.frame = CGRectMake(translationX, 0,
                                         imgVw.frame.size.width, imgVw.frame.size.height);
            }
            else if(!_on && translationX > 0.0f)
            {
                imgVw.frame = CGRectMake(gestureStartXOffset + translationX, 0,
                                         imgVw.frame.size.width, imgVw.frame.size.height);
            }
        }
            break;
            
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            if((_on && translationX < 0.0f && ABS(translationX) > _visibleWidth/4) ||
               (!_on && translationX > 0.0f && ABS(translationX) > _visibleWidth/4))
                self.on = !_on;
            else
                self.on = _on;
        }
            break;
            
        default:
            break;
    }
}

-(void)handleTap:(UITapGestureRecognizer*)tapRecognizer
{
    self.on = !_on;
}

@end
