    //
//  TypeTestView.m
//  TouchTest
//
//  Created by Alexandru Popa on 2/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TypeTestView.h"
#import "TouchTestViewController.h"
#import "PanningTest.h"
#import "PortraitKeyboard2.h"
#import "TTTouchCapturingWindow.h"
#import "TTCalloutViewController.h"


@interface TouchTestViewController ()

@property (retain, nonatomic) NSURL *url;

-(void)logEvent:(NSString *)theEventString argument:(NSString *)theArgument;
-(void)save;

@end


@implementation TypeTestView


@synthesize time;
@synthesize myTimer;
@synthesize isActive;
@synthesize button;
@synthesize	label;
@synthesize	tField;
@synthesize wordNo;
@synthesize word;
@synthesize wordL;
@synthesize wordS;
@synthesize button1;
@synthesize button2;
@synthesize button3;
@synthesize button4;
@synthesize button5;
@synthesize button6;
@synthesize button7;
@synthesize button8;
@synthesize button9;
@synthesize button10;
@synthesize button11;
@synthesize button12;
@synthesize button13;
@synthesize button14;
@synthesize button15;
@synthesize button16;
@synthesize button17;
@synthesize button18;
@synthesize button19;
@synthesize button20;
@synthesize button21;
@synthesize button22;
@synthesize button23;
@synthesize button24;
@synthesize button25;
@synthesize button26;
@synthesize button27;
@synthesize countdown;
@synthesize userInput;
@synthesize output;
@synthesize fileName;
@synthesize recIO;

+(void)initialize;
{
	// init defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *appDefaults = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0] forKey:@"LastFileId"];
	
    [defaults registerDefaults:appDefaults];
}


-(IBAction) switchToStart
{
	TouchTestViewController *view3 = [[TouchTestViewController alloc] initWithNibName:nil bundle:nil];
	[self presentModalViewController:view3 animated:NO];
}

-(IBAction) switchToNext
{
	PortraitKeyboard2 *view4 = [[PortraitKeyboard2 alloc] initWithNibName:nil bundle:nil];
	[self presentModalViewController:view4 animated:NO];
	
}

-(void) startCountdown{
    time = 150;
    //NSLog[@"Time Left %i Seconds", *time];
    myTimer = [NSTimer scheduledTimerWithTimeInterval:150 target:self selector:@selector(stopAlert)userInfo:nil repeats:NO];
    
}
-(void) updateInterface:(NSTimer*)theTimer{
    if(time >= 0&&isActive==YES){
        time --;
        //NSLog[@"Time Left %d Seconds", time];
    }
    else{
        NSLog(@"Times Up!");
        // Timer gets killed and no longer calls updateInterface
        [myTimer invalidate];
    }
    
}


-(BOOL)checkInput:(NSString*)inputString;
{
    inputString=word;
    if([tField.text isEqualToString:inputString])
    {
        return YES;
    }
    else {
        return NO;
    }   

}


-(IBAction) changeTextField: (id)sender
{
    NSLog(@"%i sad",wordNo);
    NSString *curentText=tField.text;
    NSString *title = [(UIButton *)sender currentTitle];
    curentText=[curentText stringByAppendingString:title];
    curentText=[curentText stringByAppendingString:@","];
    [tField setText:curentText];
    if ([self checkInput:tField.text]) {
        //[label setText:@"You changed me"];
        //[self changeLabel];
        [self showAlert];
        NSLog(@"%i sad",wordNo);
    }
    else{
        //[label setText:@"Wrong"];
    }
     isActive=YES;   
    [self recInput:curentText];
    [self recOutput:word];
}

-(NSString*) getWord
{   
    int i=wordNo;
    word = [[NSString alloc] init];
    int wordLength[30] = {4,5,2,7,3,1,7,3,6,9,5,7,4,2,5,7,6,3,4,2,3,1,7,4,6,8,4,5,7,5};
    wordL=wordLength[i];
    wordS=[[NSString alloc]init];
    NSString *rez=[[NSString alloc]init];
    int z;
    for(int d=1;d<=wordL;d++)
    {
        z=(arc4random()%27)+1;
        rez=[NSString stringWithFormat:@"%i",z];
        wordS=[wordS stringByAppendingString:rez];
        wordS=[wordS stringByAppendingString:@","];
    }
    //for (int q=1;q<=j;q++)
    //{
     //   int rndm=(rand()%27)+1;
      //  NSString *rndStr= [NSString stringWithFormat:@"%d",rndm];
    //    NSString *wordA=[rndStr stringByAppendingString:@" "];
    //    word=[word stringByAppendingString:wordA];
    //}
    //[self genWord:wordL];
    word=wordS;
    label.text=word;
    [self recOutput:word];
    NSLog(@"%@",word);
   
    return word;
}

-(IBAction) showAlert
{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Richtige wort" message:@"Drücken Sie Nächste, um vorwärts gehen" delegate:nil cancelButtonTitle:@"Nächste" otherButtonTitles:nil];
    tField.text=@"";
    [alert autorelease];
    [alert show];
    wordNo++;
    [self getWord];
    isActive=NO;
//    [self recOutput:word];
    [self startCountdown];
}

-(IBAction) startAlert
{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Start" message:@"Drücken Sie auf Start, zu beginnen" 
                                            delegate:nil cancelButtonTitle:@"Start" otherButtonTitles:nil];
    tField.text=@"";
    [alert autorelease];
    [alert show];
//    [self recOutput:word];
}

-(IBAction) stopAlert
{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Ende" message:@"Der Test ist beendet" 
                                                 delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    tField.text=@"";
    [alert autorelease];
    [alert show];
    isActive=NO; 
    [self save];
}
-(void)save
{
    
    NSDate* date = [NSDate date];
    
    //Create the dateformatter object
    
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    
    //Set the required date format
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    //Get the string date
    
    NSString* str = [formatter stringFromDate:date];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentsDirectory = [paths objectAtIndex:0];
    fileName=[NSString stringWithFormat:@"%@/arraySaveFile%@.txt", documentsDirectory,str];
    recIO= [[NSMutableArray alloc] init];
//    NSString *inp2=[[NSString alloc] init];
//    NSString *out2=[[NSString alloc] init];
    [recIO addObject:userInput];
    [recIO addObject:output];
    [recIO writeToFile:fileName atomically:YES];
}

-(IBAction) clearText:(id)sender
{
    NSString *thePath=tField.text;
   // NSScanner *scan=[NSScanner scannerWithString:thePath];
    NSArray *array=[thePath componentsSeparatedByString:@","];
    NSMutableArray *mutablearray=[array mutableCopy];
    
    if(sizeof(mutablearray)>1)
    {
    [mutablearray removeLastObject];
    [mutablearray removeLastObject];
    }
    else
    {
        [mutablearray insertObject:@"" atIndex:0]; 
    }
    NSString *z=[mutablearray componentsJoinedByString:@","];
    if([z length]<1)
    {
        z=z;
    }
    else
    {   
        z=[z stringByAppendingString:@","];
    }
    tField.text=z;
    }


-(BOOL)textFieldShouldBeginEditing:(UITextField *) tField 
{
    return NO;
}

-(NSMutableArray *)recOutput:(NSString*)outp
{
    outp=[outp stringByAppendingString:@" "];
    [output addObject:outp];
    NSLog(@"%@ look here <-----",output);
    return output;
}

-(NSMutableArray *)recInput:(NSString*)input
{
    //userInput=[[NSString alloc]init];
    input=[input stringByAppendingString:@" "];
    [userInput addObject:input];
    NSLog(@"%@",userInput);
    return userInput;
}


//-(BOOL) textFieldShouldReturn:(UITextField *) tField
//{
//	[tField resignFirstResponder];
//	return NO;
//}



 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    [self startAlert];
    wordNo=0;
    [self getWord];
    userInput=[[NSMutableArray alloc]init];
    output=[[NSMutableArray alloc]init];
    
    
    
    
    
    
    
    eventRecords = [[NSMutableArray alloc] init];
    
	// path that store the web
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
	documentsDirectory = [[paths objectAtIndex:0] retain];
	//NSString *webPath = [documentsDirectory stringByAppendingPathComponent:@"Website"];
	
    // recorder
//	recorder = [[TTTouchRecorder alloc] initWithView:UIView];
//	TTTouchCapturingWindow *window = [TTTouchCapturingWindow sharedWindow];
//	window.delegate = recorder;
    
	// init file numbers
//	nextFileId = [[NSUserDefaults standardUserDefaults] integerForKey:@"LastFileId"];
	//trialLabel.text = [NSString stringWithFormat:@"%03d", nextFileId];
	
	// prepare callout
    //calloutController.delegate = self;
	//calloutPopover = [[UIPopoverController alloc] initWithContentViewController:calloutController];
	//calloutPopover.popoverContentSize = CGSizeMake(300, 400);
       
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [self save];
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
