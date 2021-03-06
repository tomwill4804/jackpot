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

const int maxPicks = 6;
const int maxValue = 54;

//
//  internal function to see if a passed nsnumber is in a passed array
//
bool numberInArray(NSNumber* pnum, NSArray* parray) {
    
    for(NSNumber* anumber in parray){
        if(pnum.intValue == anumber.intValue)
            return(YES);
    }
    
    return(NO);
    
}


//
//  create a new object
//
- (instancetype)init
{
    self = [super init];
    if (self) {
        picks = [NSMutableArray array];
        self.winner = NO;
        self.payout = @"";
        self.maxPickValue = maxValue;
    }
    return self;
}

//
//  create a ticket using randon numbers
//
+(instancetype)ticketUsingQuickPick:(NSNumber*) cost{
    
    Ticket *aTicket = [[Ticket alloc] init];
    aTicket.cost = cost;
    
    do {
       [aTicket createPick];
    } while (aTicket.picks.count < maxPicks);
        
    
    return aTicket;
}

//
//  create a randon number for the ticket
//
-(void)createPick{

    int pickInt = arc4random() % maxValue + 1;
    NSNumber* pickNumber = [NSNumber numberWithInt:pickInt];
    
    if (!numberInArray(pickNumber, picks))
        [picks addObject:pickNumber];
    
}


//
//  create a ticket using passed numbers
//
+(instancetype)ticketUsingArray:(NSArray*)picks cost:(NSNumber*) cost{
    
    Ticket *aTicket = [[Ticket alloc] init];
    aTicket.cost = cost;
    [aTicket storeTheArrayIntoPicks:picks];
    
    return aTicket;
}


//
//  create a ticket using passed picks
//
-(void)storeTheArrayIntoPicks:(NSArray*)array{
    
    //
    //  use zero if we were not passed enough picks
    //
    
    [picks addObjectsFromArray:array];
    while(picks.count < maxPicks)
        [picks addObject:@(0)];

}

//
//  return copy of picks
//
-(NSMutableArray*)picks{
    
    return picks;
    
}


//
//  see if the passed ticket matches and set attributes
//
-(void)compareWithTicket:(Ticket*)anotherTicket{
    
    NSArray* payout = @[@0, @1, @1, @5, @10, @100, @1000];
    int matchCount = 0;
    
    for(NSNumber *ourNumber in picks){
        if (numberInArray(ourNumber, anotherTicket.picks))
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


//
//  return tickets picks as a string sorted
//
-(NSString*)listedPicks:(bool)sort{

    NSMutableArray *cpicks = [self.picks mutableCopy];
    
    if (sort){
        NSSortDescriptor *asc = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
        [cpicks sortUsingDescriptors:[NSArray arrayWithObject:asc]];
    }
    
    NSString *str = [[NSString alloc] init];
    for (NSNumber* pick in cpicks) {
        str = [str stringByAppendingString:[pick stringValue]];
        str = [str stringByAppendingString:@", "];
    }
    
    return [str substringToIndex:str.length - 2];
    
}

-(NSString*)description{
    
    return [self listedPicks:YES];
    
}

//
//  return tickets picks as a string with color
//
-(NSMutableAttributedString*)colorDescription:(Ticket*) anotherTicket {
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[self description]];
    NSString *oStr = [NSString stringWithFormat: @"%@,", [self description]];

    for(NSNumber *ourNumber in picks) {
        if (numberInArray(ourNumber, anotherTicket.picks)) {
            NSString *vStr = [NSString stringWithFormat: @"%@,", [ourNumber stringValue]];
            NSRange range = [oStr rangeOfString:vStr];
            if (range.location != NSNotFound)
                range.length--;
                [str addAttribute: NSForegroundColorAttributeName value: [UIColor greenColor] range: range];
        }
    }
    
    return str;
    
}


@end
