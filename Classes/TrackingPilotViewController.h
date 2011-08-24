//
//  TrackingPilotViewController.h
//  TrackingPilot
//
//  Created by Chatchavan Wacharamanotham on 01/02/2011.
//  Copyright 2011 Media Computing Group, RWTH Aachen. All rights reserved.
//

#import "TTTouchRecorder.h"
#import "TTCalloutViewController.h"

@interface TrackingPilotViewController : UIViewController <UIWebViewDelegate, TTCalloutViewControllerDelegate>
{
	// UI
	IBOutlet UIWebView *webView;
	IBOutlet UIBarButtonItem *startButton;
	IBOutlet UIBarButtonItem *webPageButton;
	IBOutlet UILabel *trialLabel;
	
	// touch recording
	TTTouchRecorder *recorder;
	
	// web page
	NSURL *url;
	TTCalloutViewController *calloutController;
	UIPopoverController	*calloutPopover;
	
	// file management
	NSString *documentsDirectory;
	NSInteger nextFileId;
	
	// other event recording
	NSMutableArray *eventRecords;
	
}

-(IBAction)startButtonPress:(id)sender;
-(IBAction)webpageButtonPress:(id)sender;

@end

