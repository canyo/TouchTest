//
//  TTCalloutViewController.h
//  TrackingPilot
//
//  Created by Chatchavan Wacharamanotham on 02/02/2011.
//  Copyright 2011 Media Computing Group, RWTH Aachen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TTCalloutViewController;

@protocol TTCalloutViewControllerDelegate

@required
-(void)didSelectedFile:(TTCalloutViewController *)theCalloutController;

@end


@interface TTCalloutViewController : UIViewController <UITableViewDataSource, UITabBarDelegate>
{
	NSInteger selectedIndex;
	
	// paths
	NSString *rootPath;
	NSArray *fileNames;
	
	// delegate
	id delegate;
}

@property (assign, nonatomic) id delegate;

// designated initializer
-(id)initWithPath:(NSString *)thePath;

-(NSURL *)selectedURL;

@end
