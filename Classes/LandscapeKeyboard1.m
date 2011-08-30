//
//  LandscapeKeyboard1.m
//  TouchTest
//
//  Created by Alexandru Popa on 6/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LandscapeKeyboard1.h"
#import "PortraitKeyboard2.h"
#import "TouchTestViewController.h"
#import "TTTouchCapturingWindow.h"
#import "TTCalloutViewController.h"
#import "TTTouchRecorder.h"


@interface TouchTestViewController ()

-(void)startRecording;
-(void)stopRecording;
-(void)saveToFile;


-(void)logEvent:(NSString *)theEventString argument:(NSString *)theArgument;
-(void)save;

@end


@implementation LandscapeKeyboard1

@synthesize time;
@synthesize myTimer2;
@synthesize isActive;
@synthesize button;
@synthesize	label;
@synthesize	tField;
@synthesize wordNo;
@synthesize charNo;
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


-(void)startRecording;
{
    [recorder startRecording];
}

-(void)stopRecording;
{
    [recorder stopRecording];
}

-(IBAction) switchToStart
{
	PortraitKeyboard2 *view3 = [[PortraitKeyboard2 alloc] initWithNibName:nil bundle:nil];
	[self presentModalViewController:view3 animated:NO];
    if ([myTimer2 isValid]) 
    {
        [myTimer2 invalidate];
    }
}

-(IBAction) switchToNext
{
	TouchTestViewController *view4 = [[TouchTestViewController alloc] initWithNibName:nil bundle:nil];
	[self presentModalViewController:view4 animated:NO];
    if ([myTimer2 isValid]) 
    {
        [myTimer2 invalidate];
    }
	
	
}

-(void) startCountdown{
    time = 150;
    //NSLog[@"Time Left %i Seconds", *time];
    myTimer2 = [NSTimer scheduledTimerWithTimeInterval:150 target:self selector:@selector(stopAlert)userInfo:nil repeats:NO];
    
}
-(void) updateInterface:(NSTimer*)theTimer{
    if(time >= 0&&isActive==YES){
        time --;
        //NSLog[@"Time Left %d Seconds", time];
    }
    else{
        NSLog(@"Times Up!");
        // Timer gets killed and no longer calls updateInterface
        [myTimer2 invalidate];
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
    NSString *title = [(UIButton *)sender currentTitle];
    NSString *curentText = title;
    curentText=[curentText stringByAppendingString:@","];
    //    wordP = [wordP stringByAppendingString:curentText];
    //    [tField setText:curentText];
    //    if ([self checkInput:tField.text]) {
    //        //[label setText:@"You changed me"];
    //        //[self changeLabel];
    //        [self showAlert];
    //        NSLog(@"%i sad",wordNo);
    //    }
    //    else{
    //        //[label setText:@"Wrong"];
    //    }
    //    isActive=YES;   
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

-(IBAction) changeTextFieldZ: (id)sender
{
    NSString *inOp =label.text;
    NSLog(@"%@ blabla",inOp);
    //NSArray *contents=[inOp componentsSeparatedByString:@","];
    NSMutableArray *contents=[[NSMutableArray alloc] initWithCapacity:[inOp length]];
    for (int i=0; i < [inOp length]; i++) 
    {
        NSString *ichar  = [NSString stringWithFormat:@"%c", [inOp characterAtIndex:i]];
        [contents addObject:ichar];
    }
    NSLog(@"%i sad",wordNo);
    NSString *curentText=tField.text;
    NSString *title = [contents objectAtIndex:charNo];
    curentText=[curentText stringByAppendingString:title];
    //curentText=[curentText stringByAppendingString:@","];
    [tField setText:curentText];
    if ([self checkInput:tField.text]) {
        //[label setText:@"You changed me"];
        //[self changeLabel];
        [self showAlert];
        NSLog(@"%i sad",wordNo);
        charNo=0;
    }
    else{
        //[label setText:@"Wrong"];charNo++;
        charNo++;
        
    }
    isActive=YES;   
    //    [self recInput:curentText];
    //    [self recOutput:word];
}


-(NSString*) getWordZ
{
    int i=wordNo;
    word = [[NSString alloc] init];
    NSArray *myArray2=[[NSArray alloc] init];
    myArray2 = [NSArray arrayWithObjects:@"agerwr",@"gksdjf",@"eksjdak",@"aksfalsfhs",@"achojshfoer",@"mcnvnqoeti",@"ngwj",@"sdewq",@"kgjflskj",@"sdkadksad",@"dsada",@"dad",@"deklte",@"gqsynham",@"dasdq",@"thbne",@"bqwepz",@"mqutz",@"qlzubp",@"neujsxtu",@"lorst",@"retsam",@"deeps",@"hextgw",@"borzm",@"penta",@"agmotc",nil];
    word=[myArray2 objectAtIndex:i];
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
    [self getWordZ];
    isActive=NO;
    //    [self recOutput:word];
    //[self startCountdown];
    NSLog(@"Timer e acum %i",myTimer2);
    
    [[TTTouchCapturingWindow sharedWindow] addViewForTouchPriority:self.view];
    [recorder startRecording];
}

-(IBAction) startAlert
{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Start" message:@"Drücken Sie auf Start, zu beginnen" 
                                                 delegate:nil cancelButtonTitle:@"Start" otherButtonTitles:nil];
    tField.text=@"";
    [alert autorelease];
    [alert show];
    charNo=0;
    //    NSString *wordP=[[NSString alloc] init];

    //    [self recOutput:word];
    [self startCountdown];
    NSLog(@"Timer e acum %i",myTimer2);
    
    [[TTTouchCapturingWindow sharedWindow] addViewForTouchPriority:self.view];
    [recorder startRecording];
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
    [self saveToFile];
    [recorder stopRecording];
    [[TTTouchCapturingWindow sharedWindow] removeViewForTouchPriority:self.view];
    
    
    [myTimer2 invalidate];
    NSLog(@"timer Stopped");
    NSLog(@"Timer e acum %i",myTimer2);
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
    fileName=[NSString stringWithFormat:@"%@/landscapeTypeTestAtTime%@.txt", documentsDirectory,str];
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
    recorder = [[TTTouchRecorder alloc] initWithView:self.view];
	TTTouchCapturingWindow *window = [TTTouchCapturingWindow sharedWindow];
	window.delegate = recorder;
    [self startAlert];
    wordNo=0;
    [self getWordZ];
    userInput=[[NSMutableArray alloc]init];
    output=[[NSMutableArray alloc]init];
    
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    NSLog(@"did call shouldAutorotateToInterfaceOrientation");
    // Overriden to allow any orientation.
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration;
{
    NSLog(@"Will rotate to: %d", toInterfaceOrientation);
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation;
{
    NSLog(@"Did rotate to: %d", [self interfaceOrientation]);
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [self save];
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
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
    NSString *fileName2=[[NSString alloc]init];
    //fileName2=[NSString stringWithFormat:@"%@/portaitTouchTrack%@.txt", documentsDirectory,str];
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
	NSString *documentsDirectory2 = [paths objectAtIndex:0];
    fileName2=[NSString stringWithFormat:@"%@/landscapeTouchTrack%@.plist", documentsDirectory2,str];
    // write data to file
	//NSString *filePath2 = [[documentsDirectory2 stringByAppendingPathComponent:fileName2] stringByAppendingPathExtension:@"plist"];
	
	NSDictionary *log = [[NSDictionary alloc] initWithObjectsAndKeys:
						 [recorder recordedTouches], @"Touches",
						 nil];
	
	[log writeToFile:fileName2 atomically:YES];
    NSLog(@"contents of log %@",log);
    // clean the recorder
    [recorder reset];
    [log release];
}


- (void)viewDidUnload {
    [super viewDidUnload];
    [myTimer2 invalidate];
    [recorder release];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end

