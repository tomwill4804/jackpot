//
//  TicketsTableViewController.m
//  Jackpot
//
//  Created by Tom Williamson on 4/20/16.
//  Copyright © 2016 Tom Williamson. All rights reserved.
//

#import "TicketsTableViewController.h"
#import "Ticket.h"

@interface TicketsTableViewController() {
    
    NSMutableArray *tickets;
    Ticket* winningTicket;
    
    float totalSpent;
    float totalWon;
    float ticketPrice;
    
}

@end

@implementation TicketsTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"";
    tickets = [[NSMutableArray alloc] init];
    winningTicket = nil;
    totalWon = 0;
    totalSpent = 0;
    ticketPrice = 1;
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return tickets.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lottoTicket" forIndexPath:indexPath];
    
    // Configure the cell...
    
    Ticket* aTicket = tickets[indexPath.row];
    cell.textLabel.text = [aTicket description];
    cell.detailTextLabel.text = aTicket.payout;
    
    if (winningTicket) {
        cell.textLabel.text = nil;
        cell.textLabel.attributedText = [aTicket colorDescription:winningTicket];
    }
    
    if (aTicket.winner)
        cell.detailTextLabel.textColor = [UIColor greenColor];
    else
        cell.detailTextLabel.textColor = [UIColor redColor];

    return cell;
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//
//  update the title
//
-(void)updateTitle{
    
    self.title = [NSString stringWithFormat:@"Spent $%g to win $%g", totalSpent, totalWon];
    
}

//
//  button to create a ticket
//
-(IBAction)createTicket:(id)sender{
    
    Ticket* aTicket = [Ticket ticketUsingQuickPick:@(ticketPrice)];
    [tickets addObject:aTicket];
    
    totalSpent += ticketPrice;
    totalWon = 0;
    [self updateTitle];
    
    [self.tableView reloadData];
    
}

//
//  button to check for a winning ticket
//
-(IBAction)checkWinners:(id)sender{
    
    //
    //  generate a new ticket
    //
    totalWon = 0;
    Ticket *winner = [Ticket ticketUsingQuickPick:@0];
    for (Ticket* ticket in tickets) {
        [ticket compareWithTicket:winner];
        totalWon += [ticket.payoutAmount intValue];
    }
    
    winningTicket = winner;
    [self updateTitle];
    
    [self.tableView reloadData];

}

@end
