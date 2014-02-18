//
//  MainScene.h
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "CCNode.h"

@interface GameScene : CCNode <CCPhysicsCollisionDelegate>
{
    CCSprite *background;
    CCSprite *floor;
    CCPhysicsNode *physics;
    CCNode *bentley;
    NSMutableArray *pipes;
    int pipesCount;
    
    int score;
    CCLabelTTF *labelScore;
}
@end
