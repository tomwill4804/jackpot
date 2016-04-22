//
//  WinningTicketViewController.m
//  Jackpot
//
//  Created by Tom Williamson on 4/21/16.
//  Copyright © 2016 Tom Williamson. All rights reserved.
//

#import "WinningTicketViewController.h"

@interface WinningTicketViewController () <UIPickerViewDelegate, UIPickerViewDataSource>{
    
    Ticket *ticket;
    
}

@end

@implementation WinningTicketViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self clearTicket:nil];
    
    self.title = @"Pick a winning ticket";
    

}

-(int) dupEntries:(NSInteger) row col:(NSInteger) col {
    
    int dup=0;
    for (int arow=1; arow <= row + 1 + dup ; arow++) {
        for(int i=0; i < ticket.picks.count; i++) {
            NSNumber *num = ticket.picks[i];
            if(i != col && [num intValue] == arow) {
                dup++;
            }
        }
    }
    
    NSLog(@"%ld - %ld = %d ", col+1, row+1, dup);
    return dup;
    
    
}

//
//  one column for each pick
//
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return ticket.picks.count;
    
}

//
//  spinner max values
//
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return ticket.maxPickValue;
}


//
//  return text for each spinner cell
//
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSInteger dup = [self dupEntries:row col:component];
    NSInteger value = (int)row + dup + 1;
    
    if (value > ticket.maxPickValue)
        return @"";
    else
        return [NSString stringWithFormat:@"%ld", (long)value];
    
}


//
//  save value selected and see if we have all picks selected
//
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    NSString *s = [self pickerView:pickerView titleForRow:row forComponent:component];
    ticket.picks[component] = @([s intValue]);
    
    self.checkTicketsBtton.enabled = YES;
    for(NSNumber *num in ticket.picks) {
        if ([num intValue] == 0)
            self.checkTicketsBtton.enabled = NO;
    }
    
    self.picksLabel.text = [ticket listedPicks:self.sortSwitch.on];
    
}


//
//  generate a random winner
//
-(IBAction)randomTicket:(UIButton*)sender{
    
    ticket = [Ticket ticketUsingQuickPick:@(0)];
    self.checkTicketsBtton.enabled = YES;
    
    for(int col=0; col < ticket.picks.count; col++) {
        int value = [ticket.picks[col] intValue];
        int dup = [self dupEntries:value-1 col:col];
        [self.pickerView selectRow:value-dup-1
                       inComponent:col animated:YES];
  //       NSLog(@"rand %d - %d = %d ", col+1, value, dup);
    }
    
    [self.pickerView reloadAllComponents];
    
    self.picksLabel.text = [ticket listedPicks:self.sortSwitch.on];
}

//
//  sort button picked
//
-(IBAction)sortList:(UISwitch*)sender{
    
    self.picksLabel.text = [ticket listedPicks:self.sortSwitch.on];
    
}

//
//  return the winning ticket
//
-(IBAction)checkTicket:(UIButton*)sender{
    
    [self.delegate returnThePickedNumbers:ticket];
    
}

-(IBAction)clearTicket:(UIButton*)sender{
    
    ticket = [Ticket ticketUsingArray:nil cost:@(0)];
    self.checkTicketsBtton.enabled = NO;
    self.picksLabel.text = [ticket listedPicks:self.sortSwitch.on];
    
    for(int col=0; col < ticket.picks.count; col++) {
        [self.pickerView selectRow:0 inComponent:col animated:YES];
    }
    
    [self.pickerView reloadAllComponents];

}



@end
