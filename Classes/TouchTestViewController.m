//
//  TouchTestViewController.m
//  TouchTest
//
//  Created by Alexandru Popa on 2/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TouchTestViewController.h"
#import "TTTouchCapturingWindow.h"
#import "TTCalloutViewController.h"
#import "PortraitKeyboard2.h"

@interface TouchTestViewController ()

-(void)saveToFile;
-(void)startRecording;
-(void)stopRecording;

@end

@implementation TouchTestViewController

@synthesize	label;
@synthesize	testNumber;
@synthesize startButton;



-(IBAction) switchView
{
	PortraitKeyboard2 *view2 = [[PortraitKeyboard2 alloc] initWithNibName:nil bundle:nil];
	[self presentModalViewController:view2 animated:YES];
}


-(IBAction) changeLabel:(id)sender;
{
    testNumber = [label.text intValue];
    testNumber = testNumber++;
    label.text=[NSString stringWithFormat:@"%i",testNumber];
}



/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
-(void)viewDidLoad 
{
	[super viewDidLoad];
	
    // recorder
	recorder = [[TTTouchRecorder alloc] initWithView:webView];
	TTTouchCapturingWindow *window = [TTTouchCapturingWindow sharedWindow];
	window.delegate = recorder;
	
	// webview delegate
	webView.delegate = self;
	
	// init view
	webView.multipleTouchEnabled = YES;
	webView.userInteractionEnabled = YES;
	
	    
	// init file numbers
	nextFileId = [[NSUserDefaults standardUserDefaults] integerForKey:@"LastFileId"];
    
	// prepare callout
////	calloutController = [[TTCalloutViewController alloc] initWithPath:webPath];
//	calloutController.delegate = self;
//	calloutPopover = [[UIPopoverController alloc] initWithContentViewController:calloutController];
//	calloutPopover.popoverContentSize = CGSizeMake(300, 400);
    
    
    
}




// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
    
    [super viewDidUnload];
    
    [recorder release];
}

-(void)startRecording;
{
    [recorder startRecording];
}

-(void)stopRecording;
{
    [recorder stopRecording];
}



-(void)saveToFile;
{
    // determine path
    
    NSDate* date = [NSDate date];
    
    //Create the dateformatter object
    
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    
    //Set the required date format
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    //Get the string date
    
    NSString* str = [formatter stringFromDate:date];
    NSString *fileName=[[NSString alloc]init];
    fileName=[NSString stringWithFormat:@"%@/StartWindowTypeTestAtTime%@.txt", documentsDirectory,str];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
    
    // write data to file
	NSString *filePath = [[documentsDirectory stringByAppendingPathComponent:fileName] stringByAppendingPathExtension:@"plist"];
	
	NSDictionary *log = [[NSDictionary alloc] initWithObjectsAndKeys:
						 [recorder recordedTouches], @"Touches",
						 nil];
	
	[log writeToFile:filePath atomically:NO];
    
    // clean the recorder
    [recorder reset];
    [log release];
}




-(IBAction)startButtonPress:(id)sender;
{
	
	if (recorder.isRecording)
	{
		// log
		[self logEvent:@"Pressed Stop Button" argument:nil];
		
		// stop recorder
		[recorder stopRecording];
		
		// save result
		[self saveToFile];
		
		// update next trial number
		nextFileId++;	
		[[NSUserDefaults standardUserDefaults] setInteger:nextFileId forKey:@"LastFileId"];
//		trialLabel.text = [NSString stringWithFormat:@"%03d", nextFileId];	
		
		// reset recorder
		[recorder reset];
		
		// update button title
		//startButton.title = @"Start";
	}
	else
	{
		// log
		[self logEvent:@"Pressed Start Button" argument:nil];
		
		// start recorder
		[recorder startRecording];
		
		// update button title
		//startButton.title = @"Stop";
	}
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



- (void)dealloc {
    [super dealloc];
}

@end
