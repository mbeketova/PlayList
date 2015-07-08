//
//  Sings.h
//  PlayList
//
//  Created by Admin on 08.07.15.
//  Copyright (c) 2015 Mariya Beketova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SingsDetails;

@interface Sings : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) SingsDetails *singsDetails;

@end
