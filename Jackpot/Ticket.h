//
//  Ticket.h
//  Jackpot
//
//  Created by Tom Williamson on 4/20/16.
//  Copyright © 2016 Tom Williamson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ticket : NSObject

@property (assign) BOOL winner;
@property (copy, nonatomic) NSString* payout;
@property (copy, nonatomic) NSNumber* payoutAmount;
@property (copy, nonatomic) NSNumber* cost;

+(instancetype)ticketUsingQuickPick:(NSNumber*) cost;
+(instancetype)ticketUsingArray:(NSArray*)picks cost:(NSNumber*) cost;

-(void)compareWithTicket:(Ticket*)anotherTicket;
-(NSArray*)picks;

@end
