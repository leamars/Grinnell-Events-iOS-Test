//
//  CalendarViewController.h
//  Grinnell-Events-iOS
//
//  Created by Lea Marolt on 10/22/13.
//  Copyright (c) 2013 Grinnell AppDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *selectedCals;

-(IBAction)done;
-(IBAction)cancel;

@end
