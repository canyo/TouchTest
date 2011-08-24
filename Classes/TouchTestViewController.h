//
//  TouchTestViewController.h
//  TouchTest
//
//  Created by Alexandru Popa on 2/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTTouchRecorder.h"
#import "TTCalloutViewController.h"

@interface TouchTestViewController : UIViewController <UIWebViewDelegate,TTCalloutViewControllerDelegate> 
{

    IBOutlet UILabel	*label;
    int testNumber;
    
    IBOutlet UIWebView *webView;
	// web page
	NSURL *url;
	TTCalloutViewController *calloutController;
	UIPopoverController	*calloutPopover;
	
	// file management
	NSString *documentsDirectory;
	NSInteger nextFileId;
	
	// other event recording
	NSMutableArray *eventRecords;
    
    IBOutlet UIButton *startButton;
    
    // touch recording
	TTTouchRecorder *recorder;
    UIImageView *imageView;
	
}

-(IBAction)startButtonPress:(id)sender;

-(IBAction) switchView;
-(IBAction) changeLabel:(id)sender;
@property (nonatomic, retain) IBOutlet UILabel *label;
@property (nonatomic) int testNumber;
@property (nonatomic, retain) IBOutlet UIButton *startButton;


@end

