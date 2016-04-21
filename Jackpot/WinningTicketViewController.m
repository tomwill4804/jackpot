//
//  WinningTicketViewController.m
//  Jackpot
//
//  Created by Tom Williamson on 4/21/16.
//  Copyright © 2016 Tom Williamson. All rights reserved.
//

#import "WinningTicketViewController.h"

@interface WinningTicketViewController () <UIPickerViewDelegate, UIPickerViewDataSource>

@end

@implementation WinningTicketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 6;
    
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return 54;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return [NSString stringWithFormat:@"%d", (int)row+1];
            
}



-(IBAction)checkTicket:(UIButton*)sender{
    
    
}

@end
