//
//  PanningTest2.h
//  TouchTest
//
//  Created by Alexandru Popa on 4/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PanningTest2 : UIViewController {
    
    CGPoint lastPoint;
	UIImageView *drawImage;
	BOOL mouseSwiped;	
	int mouseMoved;
    float targetX;
    float targetY;
    float userX;
    float userY;
    BOOL isTouching;
}

-(BOOL)isOverTarget;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
-(IBAction) switchToPrevious;
-(IBAction) switchToNext;


@property(assign)BOOL isTouching;
@property(assign) CGPoint lastPoint;
@property(assign) float targetX;
@property(assign) float targetY;
@property(assign) float userX;
@property(assign) float userY;


@end
