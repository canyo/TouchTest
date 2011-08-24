//
//  TTTouchRecorder.h
//  TrackingPilot
//
//  Created by Chatchavan Wacharamanotham on 02/02/2011.
//  Copyright 2011 Media Computing Group, RWTH Aachen. All rights reserved.
//

#import "TTTouchCapturingWindow.h"

@interface TTTouchRecorder : NSObject <TTTouchCapturingWindowDelegate>
{
	// touch
	CFMutableDictionaryRef touchMap;
	NSMutableDictionary *touchData;
	
	// view
	UIView *view;
	
	// state
	BOOL isRecording;
}

@property (readonly, nonatomic) BOOL isRecording;

// designated initializer
-(id)initWithView:(UIView *)aView;

// control methods
-(void)startRecording;
-(void)stopRecording;

// manual touch recording
-(void)addFirstTouchset:(NSSet *)touches;
-(void)addNextTouchset:(NSSet *)touches;
-(void)reset;

// output
-(NSDictionary *)recordedTouches;
@end
