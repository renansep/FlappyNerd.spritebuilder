//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "GameScene.h"
#import "Pipe.h"
#import "PipeEdge.h"

@implementation GameScene

- (void)didLoadFromCCB
{
    pipesCount = 0;
    
    [physics setGravity:ccp(0,-750)];
    physics.collisionDelegate = self;
    //.debugDraw = YES;
    
    floor.physicsBody.collisionType = @"floorCollision";
    floor.physicsBody.collisionGroup = @"obstacleGroup";
    
    bentley = [CCBReader load:@"Bentley"];
    [bentley setPosition:ccp(100, self.contentSize.height / 1.25)];
    [physics addChild:bentley];
    [bentley.physicsBody setAllowsRotation:NO];
    bentley.physicsBody.collisionGroup = @"playerGroup";
    bentley.physicsBody.collisionType = @"playerCollision";
    
    pipes = [[NSMutableArray alloc] init];

    score = 0;
    pipeSpace = 250;
    
    pipeMaxSize = 9;
    
    self.userInteractionEnabled = YES;
}

- (void)update:(CCTime)delta
{
    [floor setPosition:CGPointMake(floor.position.x - 100*delta, floor.position.y)];
    if (floor.position.x < -self.contentSize.width/2)
    {
        [floor setPosition:CGPointMake(floor.contentSize.width / 2, floor.position.y)];
    }
    
    while (pipesCount < 10)
    {
        Pipe *lastPipe = (Pipe *)[pipes lastObject];
        
        Pipe *p;
        Pipe *q;
        
        if (lastPipe != nil)
        {
            p = [[Pipe alloc] initWithMaxHeight:pipeMaxSize];
            [p setPosition:ccp(lastPipe.position.x + pipeSpace, floor.position.y + floor.contentSize.height / 2 + p.contentSize.height / 2)];
        
            q =[[Pipe alloc] initWithHeight:pipeMaxSize + 1 - [p height]];
            [q setPosition:ccp(lastPipe.position.x + pipeSpace, self.contentSize.height - q.contentSize.height / 2)];
        }
        else
        {
            p = [[Pipe alloc] initWithMaxHeight:pipeMaxSize];
            [p setPosition:ccp(400, floor.position.y + floor.contentSize.height / 2 + p.contentSize.height / 2)];
            
            q =[[Pipe alloc] initWithHeight:pipeMaxSize + 1 - [p height]];
            [q setPosition:ccp(400, self.contentSize.height - q.contentSize.height / 2)];
        }
        
        [physics addChild:p];
        [physics addChild:q];
        
        [pipes addObject:p];
        [pipes addObject:q];
        
        pipesCount+=2;
    }
    
    for (Pipe *p in pipes)
    {
        if (p.parent == physics && p.position.x < -100)
        {
            [physics removeChild:p];
            pipesCount--;
        }
    }

    if (score < 10)
    {
        [labelScore setString:[NSString stringWithFormat:@"0%d", score]];
    }
    else
    {
        [labelScore setString:[NSString stringWithFormat:@"%d", score]];
    }
    
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    [bentley.physicsBody setVelocity:ccp(0,bentley.physicsBody.velocity.y / 2)];
    [bentley.physicsBody applyImpulse:ccp(0, 200)];
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair playerCollision:(CCNode *)player pipeCollision:(CCNode *)pipe
{
    [[CCDirector sharedDirector] replaceScene:[CCBReader loadAsScene:@"MainMenu"]];
    return YES;
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair playerCollision:(CCNode *)player floorCollision:(CCNode *)floor
{
    [[CCDirector sharedDirector] replaceScene:[CCBReader loadAsScene:@"MainMenu"]];
    return YES;
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair playerCollision:(CCNode *)player scoreCollision:(CCNode *)scoreSensor
{
    score++;
    [scoreSensor removeFromParent];
    
    switch (score) {
        case 5:
            pipeSpace -= 50;
            pipeMaxSize++;
            break;
            
        case 10:
            pipeSpace -= 25;
            pipeMaxSize++;
            break;
            
        case 15:
            pipeSpace -= 25;
            pipeMaxSize++;
            break;
            
        default:
            break;
    }
    
    return YES;
}

@end
