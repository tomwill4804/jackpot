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
    
    ticket = [Ticket ticketUsingArray:nil cost:@(0)];
    self.checkTicketsBtton.enabled = NO;

}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return ticket.picks.count;
    
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return ticket.maxPickValue;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return [NSString stringWithFormat:@"%d", (int)row+1];
            
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    NSString *s = [self pickerView:pickerView titleForRow:row forComponent:component];
    ticket.picks[component] = @([s intValue]);
    
    self.checkTicketsBtton.enabled = YES;
    for(NSNumber *num in ticket.picks) {
        if ([num intValue] == 0)
            self.checkTicketsBtton.enabled = NO;
    }
    
}

-(IBAction)randomTicket:(UIButton*)sender{
    
    ticket = [Ticket ticketUsingQuickPick:@(0)];
    self.checkTicketsBtton.enabled = YES;
    [self.pickerView reloadAllComponents];
    
    for(int i=0; i < ticket.picks.count; i++) {
        int value = [ticket.picks[i] intValue];
        [self.pickerView selectRow:value-1 inComponent:i animated:YES];
    }
    
}



-(IBAction)checkTicket:(UIButton*)sender{
    
    [self.delegate returnThePickedNumbers:ticket];
    
}

@end
