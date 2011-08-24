//
//  TTTouchRecorder.m
//  TrackingPilot
//
//  Created by Chatchavan Wacharamanotham on 02/02/2011.
//  Copyright 2011 Media Computing Group, RWTH Aachen. All rights reserved.
//

#import "TTTouchRecorder.h"

@interface UITouch (PrivateAPI)

@property(assign, nonatomic, setter=_setPathMajorRadius:) CGFloat _pathMajorRadius;

@end


@interface TTTouchRecorder ()

@property (readwrite, assign, nonatomic) BOOL isRecording;
-(void)prepareTouchEntries:(NSSet *)touches;

@end


@implementation TTTouchRecorder
@synthesize isRecording;

// ---------------------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark init & cleanup
// ---------------------------------------------------------------------------------------------------------------------

-(id)initWithView:(UIView *)aView;
{
	self = [super init];
	if (self != nil) 
	{
		touchMap = CFDictionaryCreateMutable(kCFAllocatorDefault, 0, NULL, NULL);
		touchData = [[NSMutableDictionary alloc] initWithCapacity:500];
		view = [aView retain];
		
		self.isRecording = NO;
	}
	return self;
}

-(void)dealloc;
{
	[view release];
	[touchData release];
	CFRelease(touchMap);
	[super dealloc];
}

// ---------------------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark TTTouchCapturingWindowDelegate
// ---------------------------------------------------------------------------------------------------------------------

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
{
	if (isRecording)
	{
		[self addFirstTouchset:touches];
	}
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
{
	if (isRecording)
	{
		[self addNextTouchset:touches];
	}
}

// -----------------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark control methods
// -----------------------------------------------------------------------------------------------------------------
-(void)startRecording;
{
    self.isRecording = YES;
}

-(void)stopRecording;
{
    self.isRecording = NO;
}

// ---------------------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark touch recording
// ---------------------------------------------------------------------------------------------------------------------

-(void)addFirstTouchset:(NSSet *)touches;
{
	
	[self prepareTouchEntries:touches];
	[self addNextTouchset:touches];
	
}

-(void)addNextTouchset:(NSSet *)touches;
{
	for (UITouch *aTouch in touches)
	{
		NSString *key = (NSString *)CFDictionaryGetValue(touchMap, aTouch);
		
		NSMutableArray *touchArray = [touchData objectForKey:key];
        
		// debug logging
        //		CGPoint touchPoint = [aTouch locationInView:view];
        //		NSLog(@"Touch: %.0f, %.0f", touchPoint.x, touchPoint.y);
		
		NSDictionary *pointDict = (NSDictionary *) CGPointCreateDictionaryRepresentation([aTouch locationInView:view]);
		[touchArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:
							   pointDict, @"point",
							   [NSNumber numberWithDouble:aTouch.timestamp], @"timestamp",
							   [NSNumber numberWithFloat:aTouch._pathMajorRadius], @"pathMajorRadius",
							   nil]];
		[pointDict release];
	}
}

-(void)reset;
{
	[touchData removeAllObjects];
	CFDictionaryRemoveAllValues(touchMap);
}

// ---------------------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark output
// ---------------------------------------------------------------------------------------------------------------------

-(NSDictionary *)recordedTouches;
{
	return [[touchData copy] autorelease];
}

// ---------------------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark touch recording (private)
// ---------------------------------------------------------------------------------------------------------------------

-(void)prepareTouchEntries:(NSSet *)touches;
{
	for (UITouch *aTouch in touches)
	{
		CGPoint *aStartPoint = (CGPoint *)CFDictionaryGetValue(touchMap, aTouch);
		if (aStartPoint == NULL)
		{
			NSString *key = [NSStringFromCGPoint([aTouch locationInView:view]) stringByAppendingFormat:@",%f", aTouch.timestamp];
			
			// creates a placeholder for storing data
			NSMutableArray *touchArray = [[NSMutableArray alloc] init];
			[touchData setObject:touchArray forKey:key];
			[touchArray release];
			
			// remember in CFDictionary for later comparison
			CFDictionarySetValue(touchMap, aTouch, key);
			
		}
	}
	
}

@end
