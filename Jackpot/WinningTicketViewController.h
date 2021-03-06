//
//  WinningTicketViewController.h
//  Jackpot
//
//  Created by Tom Williamson on 4/21/16.
//  Copyright © 2016 Tom Williamson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ticket.h"

@protocol WinningTicketViewControllerDelegate <NSObject>

@required
-(void)returnThePickedNumbers:(Ticket*)ticket;


@end

@interface WinningTicketViewController : UIViewController

@property (weak, nonatomic) id<WinningTicketViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIButton *checkTicketsBtton;
@property (weak, nonatomic) IBOutlet UILabel *picksLabel;
@property (weak, nonatomic) IBOutlet UISwitch *sortSwitch;


-(IBAction)checkTicket:(UIButton*)sender;
-(IBAction)randomTicket:(UIButton*)sender;
-(IBAction)sortList:(UISwitch*)sender;
-(IBAction)clearTicket:(UIButton*)sender;

@end
