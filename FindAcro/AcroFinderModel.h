//
//  AcroFinderModel.h
//  FindAcro
//
//  Created by Vishal Sharma on 3/14/17.
//  Copyright © 2017 Vishal Sharma. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^FindAcroCompletionBlockHandler)(BOOL success, NSArray *outputArray);

@interface AcroFinderModel : NSObject

/**
 * Model reusable method to make Service call and return response
 */
-(void) searchAcronym:(NSString *)input completion:(FindAcroCompletionBlockHandler)findCompletion;
    
@end
