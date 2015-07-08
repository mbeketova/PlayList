//
//  ManagerAPI.h
//  PlayList
//
//  Created by Admin on 07.07.15.
//  Copyright (c) 2015 Mariya Beketova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@protocol ManagerAPIDelegate;

@interface ManagerAPI : NSObject

@property (nonatomic, weak) id<ManagerAPIDelegate> delegate;

- (void) getDataFromWall: (NSString *) method;
+ (ManagerAPI *) managerWithDelegate: (id<ManagerAPIDelegate>) aDelegate;
- (id)initWithDelegate:(id<ManagerAPIDelegate>) aDelegate;

@end

@protocol ManagerAPIDelegate <NSObject>
@required
- (void) response: (ManagerAPI *) manager Answer: (id) respObject;
- (void) responseError: (ManagerAPI *) manager Error: (NSError *) error;

@end
