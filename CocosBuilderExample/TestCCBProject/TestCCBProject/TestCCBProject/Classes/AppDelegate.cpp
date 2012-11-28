//
//  TestCCBProjectAppDelegate.cpp
//  TestCCBProject
//
//  Created by GuoDong on 12-11-28.
//  Copyright __MyCompanyName__ 2012年. All rights reserved.
//

#include "AppDelegate.h"

#include "cocos2d.h"
#include "cocos-ext.h"
#include "HelloWorldScene.h"

USING_NS_CC;
using namespace cocos2d::extension;

AppDelegate::AppDelegate()
{

}

AppDelegate::~AppDelegate()
{
}

bool AppDelegate::applicationDidFinishLaunching()
{
    // initialize director
    CCDirector *pDirector = CCDirector::sharedDirector();
    pDirector->setOpenGLView(CCEGLView::sharedOpenGLView());

    CCSize screenSize = CCEGLView::sharedOpenGLView()->getFrameSize();
    
    CCSize designSize = CCSizeMake(480, 320);
    
    if (screenSize.width == 480)
    {
        CCSize resourceSize = CCSizeMake(480, 320);
        CCFileUtils::sharedFileUtils()->setResourceDirectory("game_res/picture/480_320");
        pDirector->setContentScaleFactor(resourceSize.height/designSize.height);
    }
    else if (screenSize.width == 960 ||
             screenSize.width == 1136)
    {
        CCSize resourceSize = CCSizeMake(960, 640);
        CCFileUtils::sharedFileUtils()->setResourceDirectory("game_res/picture/960_640");
        pDirector->setContentScaleFactor(resourceSize.height/designSize.height);
    }
    
    CCEGLView::sharedOpenGLView()->setDesignResolutionSize(designSize.width, designSize.height, kResolutionNoBorder);

    // turn on display FPS
    pDirector->setDisplayStats(true);

    // set FPS. the default value is 1.0/60 if you don't call this
    pDirector->setAnimationInterval(1.0 / 60);

    // create a scene. it's an autorelease object
    //CCScene *pScene = HelloWorld::scene();
    
    /* Create an autorelease CCNodeLoaderLibrary. */
    CCNodeLoaderLibrary * ccNodeLoaderLibrary = CCNodeLoaderLibrary::newDefaultCCNodeLoaderLibrary();
    
    /* Create an autorelease CCBReader. */
    cocos2d::extension::CCBReader * ccbReader = new cocos2d::extension::CCBReader(ccNodeLoaderLibrary);
    
    CCScene *pScene = ccbReader->createSceneWithNodeGraphFromFile("game_res/ccb/Test.ccbi");
    
    ccbReader->release();
    
    // run
    pDirector->runWithScene(pScene);

    return true;
}

// This function will be called when the app is inactive. When comes a phone call,it's be invoked too
void AppDelegate::applicationDidEnterBackground()
{
    CCDirector::sharedDirector()->pause();

    // if you use SimpleAudioEngine, it must be paused
    // SimpleAudioEngine::sharedEngine()->pauseBackgroundMusic();
}

// this function will be called when the app is active again
void AppDelegate::applicationWillEnterForeground()
{
    CCDirector::sharedDirector()->resume();
    
    // if you use SimpleAudioEngine, it must resume here
    // SimpleAudioEngine::sharedEngine()->resumeBackgroundMusic();
}
