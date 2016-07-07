//
//  GroupSection.h
//  ExpandTableView
//
//  Created by VicChan on 7/7/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupSection : NSObject

@property (nonatomic, strong) NSArray *groupData;

@property (nonatomic, copy) NSString *groupName;

@property (nonatomic, assign) BOOL isExpanded;

@property (nonatomic, assign) NSInteger count;




@end
