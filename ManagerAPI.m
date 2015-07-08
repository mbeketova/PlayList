//
//  ManagerAPI.m
//  PlayList
//
//  Created by Admin on 07.07.15.
//  Copyright (c) 2015 Mariya Beketova. All rights reserved.
//

#import "ManagerAPI.h"

#define MAIN_URL @"http://kilograpp.com:8080/songs/api/"


@implementation ManagerAPI

+ (ManagerAPI *) managerWithDelegate: (id<ManagerAPIDelegate>) aDelegate {
    return [[ManagerAPI alloc] initWithDelegate:aDelegate];
}

- (id)initWithDelegate:(id<ManagerAPIDelegate>) aDelegate
{
    self = [super init];
    if (self) {
        self.delegate = aDelegate;
    }
    return self;
}


- (void) getDataFromWall: (NSString *) method {
    
    
    NSString * urlString = [NSString stringWithFormat:@"%@%@",MAIN_URL, method];
    NSURL * url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url];
    NSError * error = nil;
    NSOperationQueue * queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:req
                                       queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               
                               if (connectionError)
                               {
                                   NSLog(@"ERROR CONNECTING DATA FROM SERVER: %@", connectionError.localizedDescription);
                               }
                               
                               else if ([data length] > 0 && error == nil) {
                                   
                                   id jsonObject = [NSJSONSerialization
                                                    JSONObjectWithData:data
                                                    options:NSJSONReadingAllowFragments
                                                    error:nil];
                                   if (jsonObject != nil && error == nil) {

                                       if ([jsonObject isKindOfClass:[NSArray class]]) {

                                           if ([self.delegate respondsToSelector:@selector(response:Answer:)]) {
                                            [self.delegate response:self Answer:jsonObject];
                                           }
                                           
                                       }
                                       
                                   }
                                   
                               }
                               
                           }];
    
    
    
}

@end


