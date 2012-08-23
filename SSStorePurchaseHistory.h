//
//  SSStorePurchase.h
//  SpeechToText
//
//  Created by Shwet on 23/08/12.
//
//

#import <Foundation/Foundation.h>

@interface SSStorePurchaseHistory : NSObject <NSCoding>
{
    NSMutableArray * transactions;
}

-(NSDate *)getPurchaseDateForProduct:(NSString *)productID;
-(void)saveProductID:(NSString *)productID withPurchaseDate:(NSDate *)purchaseDate;
@end
