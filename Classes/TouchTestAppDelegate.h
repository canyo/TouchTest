//
//  TouchTestAppDelegate.h
//  TouchTest
//
//  Created by Alexandru Popa on 2/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TouchTestViewController;
@class TTTouchCapturingWindow;

@interface TouchTestAppDelegate : NSObject <UIApplicationDelegate> {
    TouchTestViewController *viewController;
    TTTouchCapturingWindow *_window;
}

@property (nonatomic, retain) IBOutlet TTTouchCapturingWindow *window;


@property (nonatomic, retain) IBOutlet TouchTestViewController *viewController;

@end

