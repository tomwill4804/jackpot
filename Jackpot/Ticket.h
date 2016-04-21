//
//  Ticket.h
//  Jackpot
//
//  Created by Tom Williamson on 4/20/16.
//  Copyright © 2016 Tom Williamson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Ticket : NSObject

@property (assign) BOOL winner;
@property (copy, nonatomic) NSString* payout;
@property (copy, nonatomic) NSNumber* payoutAmount;
@property (copy, nonatomic) NSNumber* cost;
@property (assign) int maxPickValue;


+(instancetype)ticketUsingQuickPick:(NSNumber*) cost;
+(instancetype)ticketUsingArray:(NSArray*)picks cost:(NSNumber*) cost;

-(void)compareWithTicket:(Ticket*)anotherTicket;
-(NSMutableAttributedString*)colorDescription:(Ticket*) anotherTicket;
-(NSMutableArray*)picks;

-(NSString*)listedPicks:(bool)sort;

@end
