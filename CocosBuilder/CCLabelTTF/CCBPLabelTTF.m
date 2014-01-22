/*
 * CocosBuilder: http://www.cocosbuilder.com
 *
 * Copyright (c) 2012 Zynga Inc.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#import "CCBPLabelTTF.h"

@implementation CCBPLabelTTF

- (void) setAlignment:(int)alignment
{
    self.horizontalAlignment = alignment;
}

- (int) alignment
{
    return self.horizontalAlignment;
}

- (void) setEnableShadow:(BOOL)enableShadow
{
    if (enableShadow)
    {
        [self enableShadowWithOffset:_shadowOffset opacity:_shadowOpacity blur:_shadowBlur updateImage:YES];
    }
    else
    {
        [self disableShadowAndUpdateImage:YES];
    }
}

-(BOOL) enableShadow
{
    return _shadowEnabled;
}

-(void) setLabelShadowSize:(CGSize)shadowSize
{
    if (self.enableShadow)
    {
        [self enableShadowWithOffset:shadowSize opacity:_shadowOpacity blur:_shadowBlur updateImage:YES];
    }
}

-(CGSize) labelShadowSize
{
    return _shadowOffset;
}

-(void) setLabelShadowOpacity:(float)labelShadowOpacity
{
    if (self.enableShadow)
    {
        [self enableShadowWithOffset:_shadowOffset opacity:labelShadowOpacity blur:_shadowBlur updateImage:YES];
    }
}

-(float) labelShadowOpacity
{
    return _shadowOpacity;
}

-(void) setLabelShadowBlur:(float)shadowBlur
{
    if (self.enableShadow)
    {
        [self enableShadowWithOffset:_shadowOffset opacity:_shadowOpacity blur:shadowBlur updateImage:YES];
    }
}

-(float) labelShadowBlur
{
    return _shadowBlur;
}

-(void) setEnableStroke:(BOOL)enableStroke
{
    if (enableStroke)
    {
        [self enableStrokeWithColor:_strokeColor size:_strokeSize updateImage:YES];
    }
    else
    {
        [self disableStrokeAndUpdateImage:YES];
    }
}

-(BOOL) enableStroke
{
    return _strokeEnabled;
}

-(void) setLabelStrokeSize:(float)strokeSize
{
    if (self.enableStroke)
    {
        [self enableStrokeWithColor:_strokeColor size:strokeSize updateImage:YES];
    }
}

-(float) labelStrokeSize
{
    return _strokeSize;
}

-(void) setLabelStrokeColor:(ccColor3B)labelStrokeColor
{
    if (self.enableStroke)
    {
        [self enableStrokeWithColor:labelStrokeColor size:_strokeSize updateImage:YES];
    }
}

-(ccColor3B) labelStrokeColor
{
    return _strokeColor;
}

-(void) setLabelFontColor:(ccColor3B)labelFontColor
{
    [self setColor:labelFontColor];
    [self setFontFillColor:labelFontColor updateImage:false];
}

-(ccColor3B) labelFontColor
{
    return _textFillColor;
}
@end
