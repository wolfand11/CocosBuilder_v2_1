//
//  InspectorExPos.m
//  CocosBuilder
//
//  Created by GuoDong on 13-5-7.
//
//

#import "InspectorExPos.h"
#import "CocosBuilderAppDelegate.h"
#import "CCNode+NodeInfo.h"
#import "PositionPropertySetter.h"
#import "SequencerKeyframe.h"

@implementation InspectorExPos

- (float) getPropertyWithName:(NSString*)name
{
    NSNumber* value = [selection extraPropForKey:name];
    if (value)
    {
        return [value floatValue];
    }
    else return [[selection valueForKey:name] floatValue];
}

- (void) setExPosX:(float)value
{
    [[CocosBuilderAppDelegate appDelegate] saveUndoStateWillChangeProperty:propertyName];
    
	GExPos exPos = [ExPosSetter exPositionForNode:selection prop:propertyName];
    exPos.x = value;
    [ExPosSetter setExPosition:exPos
                          type:[ExPosSetter exPositionTypeForNode:selection prop:propertyName]
                       forNode:selection
                          prop:propertyName];
    [self updateAnimateableProperty:exPos];
    [self updateAffectedProperties];
}

- (float) exPosX
{
    return [ExPosSetter exPositionForNode:selection prop:propertyName].x;
}

- (void) setExPosY:(float)value
{
    [[CocosBuilderAppDelegate appDelegate] saveUndoStateWillChangeProperty:propertyName];
    
	GExPos exPos = [ExPosSetter exPositionForNode:selection prop:propertyName];
    exPos.y = value;
    [ExPosSetter setExPosition:exPos
                          type:[ExPosSetter exPositionTypeForNode:selection prop:propertyName]
                       forNode:selection
                          prop:propertyName];
    [self updateAnimateableProperty:exPos];
    [self updateAffectedProperties];
}

- (float) exPosY
{
    return [ExPosSetter exPositionForNode:selection prop:propertyName].y;
}

- (void) setExPosExX:(float)value
{
    [[CocosBuilderAppDelegate appDelegate] saveUndoStateWillChangeProperty:propertyName];
    
	GExPos exPos = [ExPosSetter exPositionForNode:selection prop:propertyName];
    exPos.exX = value;
    [ExPosSetter setExPosition:exPos
                          type:[ExPosSetter exPositionTypeForNode:selection prop:propertyName]
                       forNode:selection
                          prop:propertyName];
    [self updateAnimateableProperty:exPos];
    [self updateAffectedProperties];
}

- (float) exPosExX
{
    return [ExPosSetter exPositionForNode:selection prop:propertyName].exX;
}

- (void) setExPosExY:(float)value
{
    [[CocosBuilderAppDelegate appDelegate] saveUndoStateWillChangeProperty:propertyName];
    
	GExPos exPos = [ExPosSetter exPositionForNode:selection prop:propertyName];
    exPos.exY = value;
    [ExPosSetter setExPosition:exPos
                          type:[ExPosSetter exPositionTypeForNode:selection prop:propertyName]
                       forNode:selection
                          prop:propertyName];
    [self updateAnimateableProperty:exPos];
    [self updateAffectedProperties];
}

- (float) exPosExY
{
    return [ExPosSetter exPositionForNode:selection prop:propertyName].exY;
}

- (void) setExPosType:(int)positionType
{
    [[CocosBuilderAppDelegate appDelegate] saveUndoStateWillChangeProperty:propertyName];
    
    int oldPositionType = self.exPosType;
    
    // Update keyframes
    NSArray* keyframes = [selection keyframesForProperty:propertyName];
    for (SequencerKeyframe* keyframe in keyframes)
    {
        keyframe.value = [self convertAnimatableValue:keyframe.value fromType:oldPositionType toType:positionType];
    }
    
    // Update base value
    id baseValue = [selection baseValueForProperty:propertyName];
    if (baseValue)
    {
        baseValue = [self convertAnimatableValue:baseValue fromType:oldPositionType toType:positionType];
        [selection setBaseValue:baseValue forProperty:propertyName];
    }
    
    [ExPosSetter setExPositionType:positionType forNode:selection prop:propertyName];
    
    [self refresh];
}

- (int) exPosType
{
    return [[selection extraPropForKey:[propertyName stringByAppendingString:@"Type"]] intValue];
}

-(void) updateAnimateableProperty:(GExPos)exPos
{
    [self updateAnimateableX:exPos.x Y:exPos.y ExX:exPos.exX ExY:exPos.exY];
}

- (void) updateAnimateableX:(float)x Y:(float)y ExX:(float)exX ExY:(float)exY
{
    [self updateAnimateablePropertyValue:
     [NSArray arrayWithObjects:
      [NSNumber numberWithFloat:x],
      [NSNumber numberWithFloat:y],
      [NSNumber numberWithFloat:exX],
      [NSNumber numberWithFloat:exY],
      nil]];
}

- (void) refresh
{
    [self willChangeValueForKey:@"exPosX"];
    [self didChangeValueForKey:@"exPosX"];
    
    [self willChangeValueForKey:@"exPosY"];
    [self didChangeValueForKey:@"exPosY"];
    
    [self willChangeValueForKey:@"exPosExX"];
    [self didChangeValueForKey:@"exPosExX"];
    
    [self willChangeValueForKey:@"exPosExY"];
    [self didChangeValueForKey:@"exPosExY"];
    
    [self willChangeValueForKey:@"exPosType"];
    [self didChangeValueForKey:@"exPosType"];
}

- (id) convertAnimatableValue:(id)value fromType:(int)fromType toType:(int)toType
{
    NSPoint relativePos = NSZeroPoint;
    relativePos.x = [[value objectAtIndex:0] floatValue];
    relativePos.y = [[value objectAtIndex:1] floatValue];
    relativePos = [PositionPropertySetter convertPosition:relativePos fromType:fromType toType:toType forNode:selection];
    
    NSPoint relativeExPos = NSZeroPoint;
    relativeExPos.x = [[value objectAtIndex:2] floatValue];
    relativeExPos.y = [[value objectAtIndex:3] floatValue];
    relativeExPos = [PositionPropertySetter convertPosition:relativeExPos fromType:fromType toType:toType forNode:selection];
    
    return [NSArray arrayWithObjects:
            [NSNumber numberWithFloat:relativePos.x],
            [NSNumber numberWithFloat:relativePos.y],
            [NSNumber numberWithFloat:relativeExPos.x],
            [NSNumber numberWithFloat:relativeExPos.y],
            [NSNumber numberWithInt:toType],
            NULL];
}

@end


@implementation ExPosSetter
+ (void) setExPosition:(GExPos)pos type:(int)type forNode:(CCNode*) node prop:(NSString*)prop
{
    [ExPosSetter setExPosition:pos type:type forNode:node prop:prop parentSize:[PositionPropertySetter getParentSize:node]];
}

+ (void) setExPosition:(GExPos)pos type:(int)type forNode:(CCNode*) node prop:(NSString*)prop parentSize:(CGSize)parentSize
{
    NSPoint absPos = [PositionPropertySetter calcAbsolutePositionFromRelative:ccp(pos.x, pos.y) type:type parentSize:parentSize];
    NSPoint absExPos = [PositionPropertySetter calcAbsolutePositionFromRelative:ccp(pos.exX, pos.exY) type:type parentSize:parentSize];
    
    
    // Set the position value
    [node setValue:[NSNumber numberWithFloat:absPos.x] forKey:[prop stringByAppendingString:@"X"]];
    [node setValue:[NSNumber numberWithFloat:absPos.y] forKey:[prop stringByAppendingString:@"Y"]];
    [node setValue:[NSNumber numberWithFloat:absExPos.x] forKey:[prop stringByAppendingString:@"ExX"]];
    [node setValue:[NSNumber numberWithFloat:absExPos.y] forKey:[prop stringByAppendingString:@"ExY"]];
    [node setValue:[NSNumber numberWithInt:type] forKey:[prop stringByAppendingString:@"Type"]];
    
    // Set the extra properties
    [node setExtraProp:[NSNumber numberWithFloat:pos.x] forKey:[prop stringByAppendingString:@"X"]];
    [node setExtraProp:[NSNumber numberWithFloat:pos.y] forKey:[prop stringByAppendingString:@"Y"]];
    [node setExtraProp:[NSNumber numberWithFloat:pos.exX] forKey:[prop stringByAppendingString:@"ExX"]];
    [node setExtraProp:[NSNumber numberWithFloat:pos.exY] forKey:[prop stringByAppendingString:@"ExY"]];
    [node setExtraProp:[NSNumber numberWithInt:type] forKey:[prop stringByAppendingString:@"Type"]];
}

+ (void) setExPosition:(GExPos)pos forNode:(CCNode *)node prop:(NSString *)prop
{
    int type = [ExPosSetter exPositionTypeForNode:node prop:prop];
    [ExPosSetter setExPosition:pos type:type forNode:node prop:prop];
}

+ (void) setExPositionType:(int)type forNode:(CCNode*)node prop:(NSString*)prop
{
    float absPosX = [[node valueForKey:[prop stringByAppendingString:@"X"]] floatValue];
    float absPosY = [[node valueForKey:[prop stringByAppendingString:@"Y"]] floatValue];
    float absPosExX = [[node valueForKey:[prop stringByAppendingString:@"ExX"]] floatValue];
    float absPosExY = [[node valueForKey:[prop stringByAppendingString:@"ExY"]] floatValue];
    
    NSPoint relPos = [PositionPropertySetter calcRelativePositionFromAbsolute:ccp(absPosX, absPosY) type:type parentSize:[PositionPropertySetter getParentSize:node]];
    NSPoint relPosEx = [PositionPropertySetter calcRelativePositionFromAbsolute:ccp(absPosExX, absPosExY) type:type parentSize:[PositionPropertySetter getParentSize:node]];
    GExPos temp;
    temp.x = relPos.x;
    temp.y = relPos.y;
    temp.exX = relPosEx.x;
    temp.exY = relPosEx.y;
    [ExPosSetter setExPosition:temp type:type forNode:node prop:prop];
}

+ (GExPos) exPositionForNode:(CCNode*)node prop:(NSString*)prop
{
    GExPos temp;
    temp.x = [[node extraPropForKey:[prop stringByAppendingString:@"X"]] floatValue];
    temp.y = [[node extraPropForKey:[prop stringByAppendingString:@"Y"]] floatValue];
    temp.exX = [[node extraPropForKey:[prop stringByAppendingString:@"ExX"]] floatValue];
    temp.exY = [[node extraPropForKey:[prop stringByAppendingString:@"ExY"]] floatValue];
    return temp;
}

+ (int) exPositionTypeForNode:(CCNode*)node prop:(NSString*)prop
{
    int tempType = [[node extraPropForKey:[prop stringByAppendingString:@"Type"]] floatValue];
    return tempType;
}
@end





