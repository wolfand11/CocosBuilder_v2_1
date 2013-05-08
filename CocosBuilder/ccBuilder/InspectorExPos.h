//
//  InspectorExPos.h
//  CocosBuilder
//
//  Created by GuoDong on 13-5-7.
//
//

#import "InspectorValue.h"

@interface InspectorExPos : InspectorValue
@property (nonatomic, assign) int exPosType;
@property (nonatomic, assign) float exPosX;
@property (nonatomic, assign) float exPosY;
@property (nonatomic, assign) float exPosExX;
@property (nonatomic, assign) float exPosExY;

@end

typedef struct
{
    float x;
    float y;
    float exX;
    float exY;
    int   type;
}GExPos;

@interface ExPosSetter : NSObject
// Setting/getting positions
+ (void) setExPosition:(GExPos)pos type:(int)type forNode:(CCNode*) node prop:(NSString*)prop;
+ (void) setExPosition:(GExPos)pos type:(int)type forNode:(CCNode*) node prop:(NSString*)prop parentSize:(CGSize)parentSize;
+ (void) setExPosition:(GExPos)pos forNode:(CCNode *)node prop:(NSString *)prop;
+ (void) setExPositionType:(int)type forNode:(CCNode*)node prop:(NSString*)prop;
+ (GExPos) exPositionForNode:(CCNode*)node prop:(NSString*)prop;
+ (int) exPositionTypeForNode:(CCNode*)node prop:(NSString*)prop;
@end