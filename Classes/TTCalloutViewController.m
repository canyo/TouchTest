//
//  TTCalloutViewController.m
//  TrackingPilot
//
//  Created by Chatchavan Wacharamanotham on 02/02/2011.
//  Copyright 2011 Media Computing Group, RWTH Aachen. All rights reserved.
//

#import "TTCalloutViewController.h"
#import <CoreGraphics/CoreGraphics.h>

@interface TTCalloutViewController ()

@property (retain, nonatomic) NSArray *fileNames;

@end


@implementation TTCalloutViewController

// ---------------------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark init & cleanup
// ---------------------------------------------------------------------------------------------------------------------

@synthesize delegate;
@synthesize fileNames;

// designated initializer
-(id)initWithPath:(NSString *)thePath;
{
	self = [super initWithNibName:@"TTCalloutView" bundle:nil];
	if (self != nil) 
	{
		rootPath = [thePath copy];
		
		// init values
		selectedIndex = -1;
	}
	return self;
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	NSAssert(NO, @"Call designated initializer instead");
	return nil;
}

- (void) dealloc
{
	self.fileNames = nil;
	[rootPath release];
	[super dealloc];
}


// ---------------------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark view
// ---------------------------------------------------------------------------------------------------------------------

-(void)viewWillAppear:(BOOL)animated;
{
	// populate file list
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
	NSArray *allFileNames = [fileManager contentsOfDirectoryAtPath:rootPath error:&error];
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF endswith[c] \"html\""];
	self.fileNames = [allFileNames filteredArrayUsingPredicate:predicate];
}

// ---------------------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark file selection
// ---------------------------------------------------------------------------------------------------------------------

-(NSURL *)selectedURL;
{
	if (selectedIndex >= 0)
	{
		return [NSURL fileURLWithPath:[rootPath stringByAppendingPathComponent:
									   [fileNames objectAtIndex:selectedIndex]]];
	}
	return nil;
}

// ---------------------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark UITableViewDataSource
// ---------------------------------------------------------------------------------------------------------------------

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
	static NSString *myIdentifier = @"FileNameCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myIdentifier];
    if (cell == nil) 
	{
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier] autorelease];
    }

    cell.textLabel.text = [fileNames objectAtIndex:indexPath.row];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
	return [fileNames count];
}

// ---------------------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark UITableViewDelegate
// ---------------------------------------------------------------------------------------------------------------------

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	selectedIndex = indexPath.row;
	
	[delegate didSelectedFile:self];
}

@end
