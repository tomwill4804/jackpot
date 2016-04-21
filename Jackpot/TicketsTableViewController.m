//
//  TicketsTableViewController.m
//  Jackpot
//
//  Created by Tom Williamson on 4/20/16.
//  Copyright © 2016 Tom Williamson. All rights reserved.
//

#import "TicketsTableViewController.h"
#import "Ticket.h"
#import "WinningTicketViewController.h"

@interface TicketsTableViewController() <WinningTicketViewControllerDelegate> {
    
    NSMutableArray *tickets;
    Ticket* winningTicket;
    
    float totalSpent;
    float totalWon;
    float ticketPrice;
    
}

@end

@implementation TicketsTableViewController

//
//  initialize values
//
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"";
    tickets = [[NSMutableArray alloc] init];
    winningTicket = nil;
    totalWon = 0;
    totalSpent = 0;
    ticketPrice = 1;
    
}


//
//  set delagate for winning view controller
//
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"pickNumbers"]) {
        
        WinningTicketViewController *wtvc = (WinningTicketViewController *)segue.destinationViewController;
        wtvc.delegate = self;
        self.title = @"";
        
    }
}


//
//  back from segue so reload table
//
-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
    
    [self updateTitle];
    [self.tableView reloadData];
    
}

#pragma mark - Table view data source

//
//  one section
//
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

//
//  one row for each ticket
//
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return tickets.count;
    
}


//
//  build text with picks for the ticket
//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lottoTicket" forIndexPath:indexPath];
    
    
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
//  delegate to get the returned numbers
//
-(void)returnThePickedNumbers:(Ticket *)ticket{
    
    //
    //  calc total winnings
    //
    totalWon = 0;
    winningTicket = ticket;
    for (Ticket* ticket in tickets) {
        [ticket compareWithTicket:winningTicket];
        totalWon += [ticket.payoutAmount intValue];
    }

}

@end
