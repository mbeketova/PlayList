//
//  CustomTableViewCell.h
//  PlayList
//
//  Created by Admin on 07.07.15.
//  Copyright (c) 2015 Mariya Beketova. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *label_Author;
@property (weak, nonatomic) IBOutlet UILabel *label_Song;

@end
