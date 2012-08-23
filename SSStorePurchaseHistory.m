//
//  SSStorePurchase.m
//  SpeechToText
//
//  Created by Shwet on 23/08/12.
//
//

#import "SSStorePurchaseHistory.h"

@implementation SSStorePurchaseHistory

- (id)init
{
    self = [super init];
    if (self) {
        transactions = [NSMutableArray array];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init])
    {
        transactions = [aDecoder decodeObjectForKey:@"Transactions"];            
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:transactions forKey:@"Transactions"];
}

-(NSDate *)getPurchaseDateForProduct:(NSString *)productID
{
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"ProductID contains[cd] %@",productID];
    NSArray * filteredArray = [transactions filteredArrayUsingPredicate:predicate];
    
    if([filteredArray count] != 0)
        return [[filteredArray objectAtIndex:0] objectForKey:@"TransactionDate"];
    return nil;
}

-(void)saveProductID:(NSString *)productID withPurchaseDate:(NSDate *)purchaseDate
{
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"ProductID contains[cd] %@",productID];
    NSArray * filteredArray = [transactions filteredArrayUsingPredicate:predicate];
    
    if([filteredArray count] != 0)
        [transactions removeObject:[filteredArray objectAtIndex:0]];
    NSDictionary * transactionData = [NSDictionary dictionaryWithObjectsAndKeys:productID, @"ProductID", purchaseDate, @"TransactionDate", nil];
    [transactions addObject:transactionData];
    
    [NSKeyedArchiver archiveRootObject:self toFile:@"PurchaseHistory"];
}

@end
