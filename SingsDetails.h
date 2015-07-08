//
//  SingsDetails.h
//  PlayList
//
//  Created by Admin on 08.07.15.
//  Copyright (c) 2015 Mariya Beketova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SingsDetails : NSManagedObject

@property (nonatomic, retain) NSString * author;
@property (nonatomic, retain) NSString * label;
@property (nonatomic, retain) NSString * id;

@end
