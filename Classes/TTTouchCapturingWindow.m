//
//  TTTouchCapturingWindow.m
//  TrackingPilot
//
//  Created by Chatchavan Wacharamanotham on 02/02/2011.
//  Copyright 2011 Media Computing Group, RWTH Aachen. All rights reserved.
//

#import "TTTouchCapturingWindow.h"

TTTouchCapturingWindow *sharedTouchCapturingWindow;

@implementation TTTouchCapturingWindow

@synthesize delegate;

// ---------------------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark class method
// ---------------------------------------------------------------------------------------------------------------------

+ (TTTouchCapturingWindow *)sharedWindow;
{
	return sharedTouchCapturingWindow;
}

// ---------------------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark init & cleanup
// ---------------------------------------------------------------------------------------------------------------------

-(void)awakeFromNib;
{
	// remember self
	sharedTouchCapturingWindow = self;
}

- (void)dealloc {
    if ( views ) [views release];
    [super dealloc];
}

- (void)addViewForTouchPriority:(UIView*)view 
{
    if ( !views ) views = [[NSMutableArray alloc] init];
    [views addObject:view];
}

- (void)removeViewForTouchPriority:(UIView*)view 
{
    if ( !views ) return;
    [views removeObject:view];
}

- (void)sendEvent:(UIEvent *)event {
    //we need to send the message to the super for the
    //text overlay to work (holding touch to show copy/paste)
    [super sendEvent:event];
	
    //get a touch
    UITouch *touch = [[event allTouches] anyObject];
	
	
	
    //check which phase the touch is at, and process it
    if (touch.phase == UITouchPhaseBegan) {
		for ( UIView *view in views ) {
			if ( CGRectContainsPoint([view frame], [touch locationInView:[view superview]]) ) {
				
				// inform delegate
				if ([delegate respondsToSelector:@selector(touchesBegan:withEvent:)])
				{
					[delegate touchesBegan:[event allTouches] withEvent:event];
				}
				
				// propagate touch
				touchView = view;
				[touchView touchesBegan:[event allTouches] withEvent:event];
				return;
			}
		}
    }
    else if (touch.phase == UITouchPhaseMoved) {
        if ( touchView ) 
		{
			// inform delegate
			if ([delegate respondsToSelector:@selector(touchesMoved:withEvent:)])
			{
				[delegate touchesMoved:[event allTouches] withEvent:event];
			}
			
			// propagate touch
            [touchView touchesMoved:[event allTouches] withEvent:event];
            return;
        }
    }
    else if (touch.phase == UITouchPhaseCancelled) {
        if ( touchView ) 
		{
			// inform delegate
			if ([delegate respondsToSelector:@selector(touchesCancelled:withEvent:)])
			{
				[delegate touchesCancelled:[event allTouches] withEvent:event];
			}
			
			// propagate touch
            [touchView touchesCancelled:[event allTouches] withEvent:event];
            touchView = nil;
            return;
        }
    }
    else if (touch.phase == UITouchPhaseEnded) {
        if ( touchView ) 
		{
			// inform delegate
			if ([delegate respondsToSelector:@selector(touchesEnded:withEvent:)])
			{
				[delegate touchesEnded:[event allTouches] withEvent:event];
			}
			
			// propagate touch
            [touchView touchesEnded:[event allTouches] withEvent:event];
            touchView = nil;
            return;
        }
    }
}
@end