//
//  APIManager.m
//  ObjectiveC2_Lesson8
//
//  Created by Admin on 31.05.15.
//  Copyright (c) 2015 Mariya Beketova. All rights reserved.
//

#import "APIManager.h"
#import "Result.h"


#define     MAIN_URL            @"http://kilograpp.com:8080/songs/api/songs"
#define     MAIN_URL_ADMIN      @"http://kilograpp.com:8080/songs/"

@implementation APIManager

+ (APIManager*) managerWhitDelegate: (id <APIManagerDelegate>) aDelegate {
    
    return [[APIManager alloc]initWhitDelegate:aDelegate];
}

- (id) initWhitDelegate: (id <APIManagerDelegate>) aDelegate {
    self = [super init];
    if (self) {
        self.delegate = aDelegate;
    }
    
    return self;
    
}

- (void) getDataFromWall: (NSDictionary*) params {
    
    
    NSURL*url = [NSURL URLWithString:MAIN_URL];
    
//    NSMutableURLRequest* req = [[NSMutableURLRequest alloc]initWithURL:url];
//    NSOperationQueue * q = [[NSOperationQueue alloc]init];
//    
//    [NSURLConnection sendAsynchronousRequest:req queue:q completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        //распаковка:
//        
//        id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//        
//    }];
//    
    
    AFHTTPRequestOperationManager * manager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:url];
    [manager GET:@"List all Songs" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
   //     Result * res = [[Result alloc] initWithDictionary:responseObject];
        
//        Получение данных:
        
//        if ([self.delegate respondsToSelector:@selector(response:Answer:)]) {
//           [self.delegate response:self Answer:res];
//        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
//        if ([self.delegate respondsToSelector:@selector(responseError:Error:)]) {
//            [self.delegate responseError:self Error:error];
//            NSLog(@"error: %@", error);
//        }

    }];
    
}
   
   
   
@end
