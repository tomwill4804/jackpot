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

}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return ticket.picks.count;
    
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return 54;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return [NSString stringWithFormat:@"%d", (int)row+1];
            
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    NSString *s = [self pickerView:pickerView titleForRow:row forComponent:component];
    ticket.picks[component] = @([s intValue]);
    
}



-(IBAction)checkTicket:(UIButton*)sender{
    
    [self.delegate returnThePickedNumbers:ticket];
    
}

@end
