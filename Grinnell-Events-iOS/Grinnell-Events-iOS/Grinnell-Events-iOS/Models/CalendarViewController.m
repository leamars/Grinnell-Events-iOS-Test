//
//  CalendarViewController.m
//  Grinnell-Events-iOS
//
//  Created by Lea Marolt on 10/22/13.
//  Copyright (c) 2013 Grinnell AppDev. All rights reserved.
//

#import "CalendarViewController.h"
#import "EventKitController.h"
#import "AppDelegate.h"

@interface CalendarViewController ()

@property (nonatomic, strong) EventKitController *eventKitController;
@property (nonatomic, strong) NSArray *allCalendars;
@property (nonatomic, strong) EKCalendar *currentCal;
@property (nonatomic, strong) NSIndexPath *checkedIndexPath;

@end

@implementation CalendarViewController {
    NSString *selectedCalander;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    self.eventKitController = [[EventKitController alloc] init];
    
    self.allCalendars = [self.eventKitController.eventStore calendarsForEntityType: EKEntityTypeEvent];
    
    self.selectedCals = [[NSMutableArray alloc] initWithCapacity:20];
    
    self.selectedCals[0] = [eventStore defaultCalendarForNewEvents];
    
    if (selectedCalander == nil) {
        selectedCalander = [eventStore defaultCalendarForNewEvents].title;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"All Calendars";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.allCalendars count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CalendarItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    UILabel *label = (UILabel *) [cell viewWithTag:10];
    
    // Set label text to calendar's title
    self.currentCal = [self.allCalendars objectAtIndex:indexPath.row];
    
    label.text = self.currentCal.title;
    
    if([self.checkedIndexPath isEqual:indexPath])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    // Set checkmark on current default calendar

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Uncheck the previous checked row
    if(self.checkedIndexPath)
    {
        UITableViewCell* uncheckCell = [tableView
                                        cellForRowAtIndexPath:self.checkedIndexPath];
        uncheckCell.accessoryType = UITableViewCellAccessoryNone;
    }
    if([self.checkedIndexPath isEqual:indexPath])
    {
        self.checkedIndexPath = nil;
    }
    else
    {
        UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
        UILabel *label = (UILabel *) [cell viewWithTag:10];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        self.checkedIndexPath = indexPath;
        selectedCalander = label.text;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)done {
    
    // Create instances of NSData
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.checkedIndexPath];
    
    UILabel *label = (UILabel *) [cell viewWithTag:10];
    selectedCalander = label.text;
    
    NSLog(@"Selected cal is: %@", selectedCalander);
    
    // Store the data
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:selectedCalander forKey:@"selectedCal"];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
