//
//  Pipe.h
//  FlappyNerd
//
//  Created by Renan Benevides Cargnin on 2/15/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCNode.h"

@class PipeEdge;

@interface Pipe : CCNode
{
    int height;
    NSMutableArray *body;
    PipeEdge *edge;
}

@property int height;
@property PipeEdge *edge;

- (Pipe *)initWithMaxHeight:(int)maxHeight;
- (Pipe *)initWithHeight:(int)fixedHeight;

@end
