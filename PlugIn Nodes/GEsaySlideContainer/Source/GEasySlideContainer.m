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
        [self setAnchorPoint:CGPointZero];
        [self setIgnoreAnchorPointForPosition:YES];
        return self;
    }
    return nil;
}

@end
