//
//  Task.h
//  TaskAppChallenge
//
//  Created by Emmanuel Cuevas on 9/21/15.
//  Copyright © 2015 Emmanuel Cuevas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Task : NSObject

@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) NSString *taskdescription;
@property (strong,nonatomic) NSDate *date;
@property (nonatomic) BOOL isCompleted;

-(id)initWithData : (NSDictionary *) data;




@end
