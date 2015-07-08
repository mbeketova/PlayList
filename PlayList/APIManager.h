//
//  APIManager.h
//  ObjectiveC2_Lesson8
//
//  Created by Admin on 31.05.15.
//  Copyright (c) 2015 Mariya Beketova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>


@protocol APIManagerDelegate;


@interface APIManager : NSObject

+ (APIManager*) managerWhitDelegate: (id <APIManagerDelegate>) aDelegate;
- (id) initWhitDelegate: (id <APIManagerDelegate>) aDelegate;
- (void) getDataFromWall: (NSDictionary*) params;

@property (nonatomic, weak) id <APIManagerDelegate> delegate;

@end


@protocol APIManagerDelegate <NSObject>

@required

- (void) response: (APIManager *) manager Answer: (id) respObject;
- (void) responseError: (APIManager *) manager Error: (NSError*) error;

@end
