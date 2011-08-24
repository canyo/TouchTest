//
//  TrackingPilotViewController.m
//  TrackingPilot
//
//  Created by Chatchavan Wacharamanotham on 01/02/2011.
//  Copyright 2011 Media Computing Group, RWTH Aachen. All rights reserved.
//

#import "TrackingPilotViewController.h"
#import "TTTouchCapturingWindow.h"
#import "TTCalloutViewController.h"

@interface TrackingPilotViewController ()

@property (retain, nonatomic) NSURL *url;

-(void)logEvent:(NSString *)theEventString argument:(NSString *)theArgument;
-(void)save;

@end


@implementation TrackingPilotViewController

@synthesize url;


// ---------------------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark class method
// ---------------------------------------------------------------------------------------------------------------------

+(void)initialize;
{
	// init defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *appDefaults = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0] forKey:@"LastFileId"];
	
    [defaults registerDefaults:appDefaults];
}

// ---------------------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark init & cleanup
// ---------------------------------------------------------------------------------------------------------------------

-(void)viewDidLoad 
{
	[super viewDidLoad];
	
	// event record
	eventRecords = [[NSMutableArray alloc] init];

	// path that store the web
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
	documentsDirectory = [[paths objectAtIndex:0] retain];
	NSString *webPath = [documentsDirectory stringByAppendingPathComponent:@"Website"];
	
	// webview delegate
	webView.delegate = self;
	
	// init view
	webView.multipleTouchEnabled = YES;
	webView.userInteractionEnabled = YES;
	
	// recorder
	recorder = [[TTTouchRecorder alloc] initWithView:webView];
	TTTouchCapturingWindow *window = [TTTouchCapturingWindow sharedWindow];
	window.delegate = recorder;
		
	// init file numbers
	nextFileId = [[NSUserDefaults standardUserDefaults] integerForKey:@"LastFileId"];
	trialLabel.text = [NSString stringWithFormat:@"%03d", nextFileId];
	
	// prepare callout
	calloutController = [[TTCalloutViewController alloc] initWithPath:webPath];
	calloutController.delegate = self;
	calloutPopover = [[UIPopoverController alloc] initWithContentViewController:calloutController];
	calloutPopover.popoverContentSize = CGSizeMake(300, 400);
		
	// load the page
	self.url = [NSURL fileURLWithPath:[webPath stringByAppendingPathComponent:@"Aachen.html"]];
	[webView loadRequest:[NSURLRequest requestWithURL:self.url]];
}



-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
    return YES;
}

-(void)didReceiveMemoryWarning 
{
	[self save];
	[super didReceiveMemoryWarning];
}

-(void)viewDidUnload 
{
	[calloutPopover release];
	calloutController.delegate = nil;
	[calloutController release];
	
	
	TTTouchCapturingWindow *window = [TTTouchCapturingWindow sharedWindow];
	window.delegate = nil;
	
	webView.delegate = nil;
	
	[documentsDirectory release];
	
	[recorder release];

	[eventRecords release];
}


// ---------------------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark UI event handling
// ---------------------------------------------------------------------------------------------------------------------

-(IBAction)startButtonPress:(id)sender;
{
	
	if (recorder.isRecording)
	{
		// log
		[self logEvent:@"Pressed Stop Button" argument:nil];
		
		// stop recorder
		[recorder stopRecording];
		
		// save result
		[self save];
		
		// update next trial number
		nextFileId++;	
		[[NSUserDefaults standardUserDefaults] setInteger:nextFileId forKey:@"LastFileId"];
		trialLabel.text = [NSString stringWithFormat:@"%03d", nextFileId];	
		
		// reset recorder
		[recorder reset];
		
		// update button title
		startButton.title = @"Start";
	}
	else
	{
		// log
		[self logEvent:@"Pressed Start Button" argument:nil];
		
		// start recorder
        [recorder startRecording];
		
		// update button title
		startButton.title = @"Stop";
	}
}


-(IBAction)webpageButtonPress:(id)sender;
{
	// log
	[self logEvent:@"Pressed Webpage Button" argument:nil];
	
	[calloutPopover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

// ---------------------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark UIWebViewDelegate
// ---------------------------------------------------------------------------------------------------------------------

// No loading other page
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
{
	if ([[[request URL] relativePath] isEqual:[self.url relativePath]])
	{
		[self logEvent:@"Loaded file" argument:[[request URL] lastPathComponent]];
		return YES;
	}
	
	return NO;
}


// ---------------------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark TTCalloutViewControllerDelegate
// ---------------------------------------------------------------------------------------------------------------------

-(void)didSelectedFile:(TTCalloutViewController *)theCalloutController;
{
	self.url = [theCalloutController selectedURL];
	
	[webView loadRequest:[NSURLRequest requestWithURL:self.url]];
	[calloutPopover dismissPopoverAnimated:YES];
}


// ---------------------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark file management
// ---------------------------------------------------------------------------------------------------------------------

-(void)save;
{
	// write data to file
	NSString *filePath = [[documentsDirectory stringByAppendingPathComponent:trialLabel.text] stringByAppendingPathExtension:@"plist"];
	
	NSDictionary *log = [[NSDictionary alloc] initWithObjectsAndKeys:
						 [recorder recordedTouches], @"Touches",
						 eventRecords, @"Events",
						 nil];
	
	[log writeToFile:filePath atomically:NO];
	
	// clean event records
	[eventRecords removeAllObjects];
	
	// cleanup
	[log release];
}

// ---------------------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark event recording
// ---------------------------------------------------------------------------------------------------------------------

-(void)logEvent:(NSString *)theEventString argument:(NSString *)theArgument;
{
	NSTimeInterval timestamp = [[NSProcessInfo processInfo] systemUptime]; 
	
	NSMutableDictionary *eventDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
							   theEventString, @"event",
							   [NSNumber numberWithDouble:timestamp], @"timestamp",
							   nil];
	
	if (theArgument != nil)
	{
		[eventDict setObject:theArgument forKey:@"argument"];
	}
	
	[eventRecords addObject:eventDict];
	
	[eventDict release];
}

@end
