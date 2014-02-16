//
//  MainMenu.m
//  FlappyNerd
//
//  Created by Renan Benevides Cargnin on 2/16/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "MainMenu.h"

@implementation MainMenu

- (void)launchGame:(id)sender
{
    [[CCDirector sharedDirector] replaceScene:[CCBReader loadAsScene:@"GameScene"]];
}

@end
