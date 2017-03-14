//
//  AcroFinderModel.m
//  FindAcro
//
//  Created by Vishal Sharma on 3/14/17.
//  Copyright © 2017 Vishal Sharma. All rights reserved.
//

#import "AcroFinderModel.h"

@implementation AcroFinderModel

/**
 * Model reusable method to make Service call
 */
-(void) searchAcronym:(NSString *)input completion:(FindAcroCompletionBlockHandler)findCompletion
{
    __block FindAcroCompletionBlockHandler blockHandler = findCompletion;
    NSString *urlString = [NSString stringWithFormat:
                           @"http://www.nactem.ac.uk/software/acromine/dictionary.py?sf=%@",
                           input];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:
                             [NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSArray *returnedArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
            blockHandler(NO,nil);
        }
        else{
            NSArray* outputResponse = [returnedArray objectAtIndex:0];
            NSArray* outputArray = [[outputResponse valueForKey:@"lfs"] valueForKey:@"lf"];
            blockHandler(YES, outputArray);
        }
    }] resume];
}

@end
