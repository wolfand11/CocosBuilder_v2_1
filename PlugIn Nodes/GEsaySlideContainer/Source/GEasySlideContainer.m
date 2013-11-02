//
//  GEasySlideContainer.m
//  GEasySlideContainer
//
//  Created by GuoDong on 12-12-29.
//
//

#import "GEasySlideContainer.h"

@implementation GEasySlideContainer

-(id) init
{
    if ([super init])
    {
        // ccb 通过 anchorPoint来保存Container的slideDirection
        // anchorPoint.y = 0 slideDirection = horizontal
        // anchorPoint.y = 1 slideDirection = vertical
        [self setAnchorPoint:CGPointZero];
        [self setIgnoreAnchorPointForPosition:NO];
        // ccb 通过position contentSize来保存Container的touchRect属性
        [self setContentSize:CGSizeMake(100.0f, 100.0f)];
        return self;
    }
    return nil;
}

@end
