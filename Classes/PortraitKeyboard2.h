//
//  PortraitKeyboard2.h
//  TouchTest
//
//  Created by Alexandru Popa on 6/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTTouchRecorder.h"
#import "TTCalloutViewController.h"

@interface PortraitKeyboard2 : UIViewController {
    
    
    TTTouchRecorder *recorder;
    NSString *documentsDirectory;
	NSInteger nextFileId;
    NSMutableArray *eventRecords;
    IBOutlet UIButton *button;
    IBOutlet UILabel	*label;
    IBOutlet UITextField *tField;
    BOOL isActive;
    NSTimer *myTimer;
    NSInteger *time;
    NSMutableArray *userInput;
    NSMutableArray *output;
    NSString *fileName;
    NSMutableArray *recIO;
    IBOutlet UIButton *button1;
    IBOutlet UIButton *button2;
    IBOutlet UIButton *button3;
    IBOutlet UIButton *button4;
    IBOutlet UIButton *button5;
    IBOutlet UIButton *button6;
    IBOutlet UIButton *button7;
    IBOutlet UIButton *button8;
    IBOutlet UIButton *button9;
    IBOutlet UIButton *button10;
    IBOutlet UIButton *button11;
    IBOutlet UIButton *button12;
    IBOutlet UIButton *button13;
    IBOutlet UIButton *button14;
    IBOutlet UIButton *button15;
    IBOutlet UIButton *button16;
    IBOutlet UIButton *button17;
    IBOutlet UIButton *button18;
    IBOutlet UIButton *button19;
    IBOutlet UIButton *button20;
    IBOutlet UIButton *button21;
    IBOutlet UIButton *button22;
    IBOutlet UIButton *button23;
    IBOutlet UIButton *button24;
    IBOutlet UIButton *button25;
    IBOutlet UIButton *button26;
    IBOutlet UIButton *button27;
    
    // touch recording
    UIImageView *imageView;

}

-(void)advanceTimer:(NSTimer *)timer;
-(IBAction)startCountdown:(id)sender;
-(BOOL)checkInput:(NSString*)inputString;
-(NSString*)getWord;
-(NSString*)getWordZ;
-(IBAction) switchToStart;
-(IBAction) showAlert;
-(IBAction) startAlert;
-(IBAction) stopAlert;
-(IBAction) switchToNext;
-(IBAction) changeButtonTitle: (id)sender;
-(IBAction) changeTextField: (id)sender;
-(IBAction) changeTextFieldZ: (id)sender;

//-(void) changeLabel;
-(BOOL)textFieldShouldBeginEditing:(UITextField *)tField;
-(IBAction) clearText:(id)sender;
-(NSMutableArray*) recInput:(NSString*)input;
-(NSMutableArray*) recOutput:(NSString*)outp;

-(void)save;
-(void) updateInterface:(NSTimer*)theTimer;
-(void) startCountdown;



@property (nonatomic,assign) NSTimer *myTimer;
@property (nonatomic,assign) NSInteger *time;

@property (nonatomic, retain) IBOutlet UIButton *button;
@property (nonatomic, retain) IBOutlet UILabel *label;
@property (nonatomic, retain) IBOutlet UITextField *tField;
@property (nonatomic, retain) IBOutlet UIButton *button1;
@property (nonatomic, retain) IBOutlet UIButton *button2;
@property (nonatomic, retain) IBOutlet UIButton *button3;
@property (nonatomic, retain) IBOutlet UIButton *button4;
@property (nonatomic, retain) IBOutlet UIButton *button5;
@property (nonatomic, retain) IBOutlet UIButton *button6;
@property (nonatomic, retain) IBOutlet UIButton *button7;
@property (nonatomic, retain) IBOutlet UIButton *button8;
@property (nonatomic, retain) IBOutlet UIButton *button9;
@property (nonatomic, retain) IBOutlet UIButton *button10;
@property (nonatomic, retain) IBOutlet UIButton *button11;
@property (nonatomic, retain) IBOutlet UIButton *button12;
@property (nonatomic, retain) IBOutlet UIButton *button13;
@property (nonatomic, retain) IBOutlet UIButton *button14;
@property (nonatomic, retain) IBOutlet UIButton *button15;
@property (nonatomic, retain) IBOutlet UIButton *button16;
@property (nonatomic, retain) IBOutlet UIButton *button17;
@property (nonatomic, retain) IBOutlet UIButton *button18;
@property (nonatomic, retain) IBOutlet UIButton *button19;
@property (nonatomic, retain) IBOutlet UIButton *button20;
@property (nonatomic, retain) IBOutlet UIButton *button21;
@property (nonatomic, retain) IBOutlet UIButton *button22;
@property (nonatomic, retain) IBOutlet UIButton *button23;
@property (nonatomic, retain) IBOutlet UIButton *button24;
@property (nonatomic, retain) IBOutlet UIButton *button25;
@property (nonatomic, retain) IBOutlet UIButton *button26;
@property (nonatomic, retain) IBOutlet UIButton *button27;

@property (nonatomic, retain)NSMutableArray *recIO;
@property (nonatomic) int wordNo;
@property (nonatomic) int charNo;
@property (nonatomic) int countdown;
@property (nonatomic, retain) NSString *wordS;
@property (nonatomic, retain) NSString *wordZ;
@property (nonatomic, retain) NSString *wordP;
@property (nonatomic, retain) NSMutableArray *userInput;
@property (nonatomic, retain) NSMutableArray *output;
@property (nonatomic, retain) NSString *fileName;
@property (nonatomic, assign) int wordL;
@property (nonatomic,retain) NSString *word;
@property  (nonatomic,assign) BOOL isActive;

@end
