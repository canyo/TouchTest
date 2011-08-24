//
//  TTTouchCapturingWindow.h
//  TrackingPilot
//
//  Created by Chatchavan Wacharamanotham on 02/02/2011.
//  Copyright 2011 Media Computing Group, RWTH Aachen. All rights reserved.
//
//  Inspired by: http://blog.wyldco.com/2010/11/how-to-capture-touches-over-a-uiwebview/

@class TTTouchCapturingWindow;

@protocol TTTouchCapturingWindowDelegate <NSObject>

@optional
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;

@end


@interface TTTouchCapturingWindow : UIWindow 
{
    NSMutableArray *views;
	
@private
    UIView *touchView;
	id<TTTouchCapturingWindowDelegate> delegate;
}

@property (assign) id<TTTouchCapturingWindowDelegate> delegate;

+ (TTTouchCapturingWindow *)sharedWindow;

- (void)addViewForTouchPriority:(UIView*)view;
- (void)removeViewForTouchPriority:(UIView*)view;

@end