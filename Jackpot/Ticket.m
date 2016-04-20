//
//  Ticket.m
//  Jackpot
//
//  Created by Tom Williamson on 4/20/16.
//  Copyright © 2016 Tom Williamson. All rights reserved.
//

#import "Ticket.h"

@interface Ticket() {
    
    NSMutableArray *picks;
    
}


@end

@implementation Ticket

- (instancetype)init
{
    self = [super init];
    if (self) {
        picks = [NSMutableArray array];
        self.winner = NO;
        self.payout = @"";
    }
    return self;
}

+(instancetype)ticketUsingQuickPick:(NSNumber*) cost{
    
    Ticket *aTicket = [[Ticket alloc] init];
    aTicket.cost = cost;
    
    do {
       [aTicket createPick];
    } while (aTicket.picks.count < 6);
        
    
    return aTicket;
}

+(instancetype)ticketUsingArray:(NSArray*)picks cost:(NSNumber*) cost{
    
    Ticket *aTicket = [[Ticket alloc] init];
    aTicket.cost = cost;
    [aTicket storeTheArrayIntoPicks:picks];
    
    return aTicket;
}

-(void)storeTheArrayIntoPicks:(NSArray*)array{
    
    picks = [array mutableCopy];
    
}

bool numberInArray(NSNumber* pnum, NSArray* parray) {
    
    for(NSNumber* anumber in parray){
        if(pnum.intValue == anumber.intValue)
            return(YES);
    }

    return(NO);
    
}


-(void)createPick{
    
    int pickInt = arc4random() % 54 + 1;
    NSNumber* pickNumber = [NSNumber numberWithInt:pickInt];
    
    if (!numberInArray(pickNumber, picks))
        [picks addObject:pickNumber];
    
}


-(NSArray*)picks{
    
    return [picks copy];
    
}

-(void)compareWithTicket:(Ticket*)anotherTicket{
    
    NSArray* payout = @[@0, @1, @1, @5, @10, @100, @1000];
    int matchCount = 0;
    
    for(NSNumber *ourNumber in picks){
        if (numberInArray(ourNumber, picks))
            matchCount++;
    }
    
    if (matchCount > 0) {
        self.winner = YES;
        self.payoutAmount = payout[matchCount];
        self.payout = [NSString stringWithFormat:@"$%@", self.payoutAmount];
    }
    else {
        self.winner = NO;
        self.payoutAmount = 0;
        self.payout = @"Sorry, please play again";
     }
    
}

-(NSString*)description{
    
    return [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@", picks[0], picks[1], picks[2], picks[3], picks[4], picks[5] ];
    
}

@end
