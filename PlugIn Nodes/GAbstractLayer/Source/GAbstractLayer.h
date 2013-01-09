//
//  GAbstractLayer.h
//  GAbstractLayer
//
//  Created by guodong on 13-1-10.
//
//

#import "cocos2d.h"

@interface GAbstractLayer : CCLayer
{
    BOOL isSwallowTouchs_;
}
@property(readwrite,nonatomic,assign)BOOL isSwallowTouchs;
@end
