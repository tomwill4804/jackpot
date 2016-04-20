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

+(instancetype)ticketUsingQuickPick{
    
    Ticket *aTicket = [[Ticket alloc] init];
    
    do {
       [aTicket createPick];
    } while (aTicket.picks.count < 6);
        
    
    return aTicket;
}

+(instancetype)ticketUsingArray:(NSArray*)picks{
    
    Ticket *aTicket = [[Ticket alloc] init];
    [aTicket storeTheArrayIntoPicks:picks];
    
    return aTicket;
}

-(void)storeTheArrayIntoPicks:(NSArray*)array{
    
    picks = [array mutableCopy];
    
}
         
-(void)createPick{
    
    int pickInt = arc4random() % 54 + 1;
    NSNumber* pickNumber = [NSNumber numberWithInt:pickInt];
    
    BOOL dontAdd = NO;
    for(NSNumber* entry in picks) {
        if (entry.intValue == pickInt)
            dontAdd = YES;
    }
        
    if (!dontAdd)
        [picks addObject:pickNumber];
}


-(NSArray*)picks{
    
    return [picks copy];
    
}

-(void)compareWithTicket:(Ticket*)anotherTicket{
    
    NSArray* possibleWinningNumbers = anotherTicket.picks;
    int matchCount = 0;
    
    for(NSNumber *ourNumber in picks){
        for(NSNumber *theirNumber in possibleWinningNumbers){
            if(ourNumber.intValue == theirNumber.intValue)
                matchCount++;
        }
    }
    
    switch (matchCount) {
        case 1:
            self.winner = YES;
            self.payout = @"$1";
            break;
        case 2:
            self.winner = YES;
            self.payout = @"$1";
            break;
        case 3:
            self.winner = YES;
            self.payout = @"$5";
            break;
        case 4:
            self.winner = YES;
            self.payout = @"$10";
            break;
        case 5:
            self.winner = YES;
            self.payout = @"$100";
            break;
        case 6:
            self.winner = YES;
            self.payout = @"$1000";
            break;
        default:
            self.payout = @"sorry please play again";
            break;
    }
    
    
}

@end
