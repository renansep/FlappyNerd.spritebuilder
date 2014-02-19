//
//  Pipe.m
//  FlappyNerd
//
//  Created by Renan Benevides Cargnin on 2/15/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Pipe.h"
#import "PipeBody.h"
#import "PipeEdge.h"

@implementation Pipe

@synthesize height, edge;

- (Pipe *)initWithMaxHeight:(int)maxHeight
{
    self = [super init];
    if (self)
    {
        body = [[NSMutableArray alloc] init];
        height = arc4random() % maxHeight + 1;
        for (int i=0; i<height; i++)
        {
            PipeBody *p = (PipeBody *) [CCBReader load:@"pipeBody"];
            [body addObject:p];
            
            [p setPosition:ccp(p.contentSize.width / 2, (i+1) * (p.contentSize.height / 2))];
            
            p.physicsBody.collisionType = @"pipeCollision";
            
            [self addChild:p];
        }
        
        PipeBody *pb = (PipeBody *) [body lastObject];
        edge = (PipeEdge *) [CCBReader load:@"pipeEdge"];
        
        [edge setPosition:ccp(pb.position.x, pb.position.y + pb.contentSize.height / 2 + edge.contentSize.height / 2)];
        
        edge.physicsBody.collisionType = @"pipeCollision";
        
        scoreSensor = [[CCNode alloc] init];
        scoreSensor.physicsBody = [CCPhysicsBody bodyWithRect:CGRectMake(edge.position.x, 0, 10, 320) cornerRadius:0];
        scoreSensor.physicsBody.sensor = YES;
        scoreSensor.physicsBody.collisionType = @"scoreCollision";
        scoreSensor.physicsBody.affectedByGravity = NO;
        [self addChild:scoreSensor];
        
        [self addChild:edge];
    }
    return self;
}

- (Pipe *)initWithHeight:(int)fixedHeight
{
    self = [super init];
    if (self)
    {
        body = [[NSMutableArray alloc] init];
        height = fixedHeight;
        for (int i=0; i<height; i++)
        {
            PipeBody *p = (PipeBody *) [CCBReader load:@"pipeBody"];
            [body addObject:p];
            
            [p setRotation:180];
            
            [p setPosition:ccp(p.contentSize.width / 2, -((i+1) * (p.contentSize.height / 2)))];
            
            p.physicsBody.collisionType = @"pipeCollision";
            
            [self addChild:p];
        }
        
        PipeBody *pb = (PipeBody *) [body lastObject];
        edge = (PipeEdge *) [CCBReader load:@"pipeEdge"];
        
        [edge setRotation:180];
        [edge setPosition:ccp(pb.position.x, pb.position.y - pb.contentSize.height / 2 - edge.contentSize.height / 2)];
        edge.physicsBody.collisionType = @"pipeCollision";
        
        [self addChild:edge];
    }
    return self;
}

- (void)update:(CCTime)delta
{
    for (PipeBody *pb in body)
    {
        [pb setPosition:ccp(pb.position.x - 100*delta, pb.position.y)];
    }
    [edge setPosition:ccp(edge.position.x - 100*delta, edge.position.y)];
    [scoreSensor setPosition:ccp(scoreSensor.position.x - 100*delta, scoreSensor.position.y)];
    [self setPosition:ccp(self.position.x - 100*delta, self.position.y)];
}

@end
