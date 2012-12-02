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
    
    CCSize designSize = CCSizeMake(1.0f, 1.0f);
    CCSize resourceSize = CCSizeMake(1.0f, 1.0f);
    
    // 方案一：每一个分辨率出一份资源
//    if (screenSize.width == 480)
//    {
//        resourceSize = CCSizeMake(480, 320);
//        designSize = CCSizeMake(480, 320);
//        CCFileUtils::sharedFileUtils()->setResourceDirectory("game_res/480_320");
//        pDirector->setContentScaleFactor(resourceSize.height/designSize.height);
//    }

    if (screenSize.width == 960 || screenSize.width == 1136)
    {
        resourceSize = screenSize;
        designSize = screenSize;
        CCFileUtils::sharedFileUtils()->setResourceDirectory("game_res/960_640");
        pDirector->setContentScaleFactor(1.0f);
    }
    else if (screenSize.width == 1024 ||
             screenSize.width == 2048)
    {
        resourceSize = designSize = screenSize;
        CCFileUtils::sharedFileUtils()->setResourceDirectory("game_res/1024_768");
        pDirector->setContentScaleFactor(1.0f);
    }
    // 方案二：比例相同的使用同一份资源，对显示的内容进行缩放
    else
    {
        if (screenSize.width*2 == screenSize.height*3)
        {
            designSize = CCSizeMake(960, 640);
            CCFileUtils::sharedFileUtils()->setResourceDirectory("game_res/960_640");
            pDirector->setContentScaleFactor(screenSize.height/designSize.height);
        }
        else if (screenSize.width*3 == screenSize.height*4)
        {
            designSize = CCSizeMake(1024, 768);
            CCFileUtils::sharedFileUtils()->setResourceDirectory("game_res/1024_768");
            pDirector->setContentScaleFactor(screenSize.height/designSize.height);
        }
        else
        {
            CCLOG("unsupport screenSize:(w-%f,h-%f)",screenSize.width,screenSize.height);
        }
    }
    CCLOG("current designSize:(w-%f,h-%f)",designSize.width,designSize.height);
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
    
    CCScene *pScene = ccbReader->createSceneWithNodeGraphFromFile("ccb/Test.ccbi");
    
    CCSprite* sprite = CCSprite::create("Icon.png");
    sprite->setAnchorPoint(ccp(0, 0));
    sprite->setPosition(ccp(0,0));
    pScene->addChild(sprite,10);
    
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
