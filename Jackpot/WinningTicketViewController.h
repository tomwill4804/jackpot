//
//  WinningTicketViewController.h
//  Jackpot
//
//  Created by Tom Williamson on 4/21/16.
//  Copyright © 2016 Tom Williamson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WinningTicketViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIPickerView* pickerView;

-(IBAction)checkTicket:(UIButton*)sender;

@end
