//
//  ItemViewController.m
//  HomePwner
//
//  Created by Sander Peerna on 6/19/15.
//  Copyright (c) 2015 Sander Peerna. All rights reserved.
//

#import "DetailViewController.h"
#import "ItemViewController.h"
#import "ItemStore.h"
#import "Item.h"

@interface ItemViewController ()

@end

@implementation ItemViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINavigationItem *navItem = self.navigationItem;
    navItem.title = @"HomePwner";
    
    for (int i = 0; i < 5; i++) {
        [[ItemStore sharedStore] createItem];
    }
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addNewItem:(id)sender
{
    // Create a new Item and add it to the store
    Item *newItem = [[ItemStore sharedStore] createItem];
    
    // Figure out where that item is in the array
    NSInteger lastRow = [[[ItemStore sharedStore] allItems] indexOfObject:newItem];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
        
    // Insert this new row into the table.
    [self.tableView insertRowsAtIndexPaths:@[indexPath]
                            withRowAnimation:UITableViewRowAnimationTop];
}

- (IBAction)toggleEditingMode:(id)sender
{
    // If you are currently in editing mode...
    if (self.isEditing) {
            
        // Change text of button to inform user of state
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
            
        // Turn off editing mode
        [self setEditing:NO animated:YES];
    } else {
        
        // Change text of button to inform user of state
        [sender setTitle:@"Done" forState:UIControlStateNormal];
            
        // Enter editing mode
        [self setEditing:YES animated:YES];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[[ItemStore sharedStore] allItems] count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"
                                                            forIndexPath:indexPath];
    
    // Configure the cell...
    NSArray *items = [[ItemStore sharedStore] allItems];
    
    if (indexPath.row < [items count]) {
        Item *item = items[indexPath.row];
        cell.textLabel.text = [item description];
        cell.textLabel.font = [UIFont systemFontOfSize:20.0];
    } else {
        cell.textLabel.text = @"No more items!";
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row < [[[ItemStore sharedStore] allItems] count]) {
        return 60;
    } else {
        return 44;
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        NSArray *items = [[ItemStore sharedStore] allItems];
        Item *item = items[indexPath.row];
        [[ItemStore sharedStore] removeItem:item];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    [[ItemStore sharedStore] moveItemAtIndex:fromIndexPath.row toIndex:toIndexPath.row];
}

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    if (indexPath.row == [[[ItemStore sharedStore] allItems] count])
        return NO;
    return YES;
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    if (proposedDestinationIndexPath.row == [[[ItemStore sharedStore] allItems] count])
        return sourceIndexPath;
    else
        return proposedDestinationIndexPath;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"AddItem"]) {
        Item *newItem = [[Item alloc] init];
        UINavigationController *nc = (UINavigationController *)segue.destinationViewController;
        DetailViewController *dvc = (DetailViewController *)[nc topViewController];
        dvc.item = newItem;
        [[ItemStore sharedStore] addItem:newItem];
    } else if ([segue.identifier isEqualToString:@"EditItem"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        NSArray *items = [[ItemStore sharedStore] allItems];
        Item *editItem = items[indexPath.row];
        DetailViewController *cvc = (DetailViewController *)segue.destinationViewController;
        cvc.item = editItem;
    }
}

@end
