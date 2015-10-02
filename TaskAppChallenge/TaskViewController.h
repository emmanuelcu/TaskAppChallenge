//
//  TaskViewController.h
//  TaskAppChallenge
//
//  Created by Emmanuel Cuevas on 9/19/15.
//  Copyright © 2015 Emmanuel Cuevas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"
#import "EditTaskViewController.h"

@protocol TaskViewControllerDelegate <NSObject>

-(void)updateTask;

@end

@interface TaskViewController : UIViewController <EditTaskViewControllerDelegate>
@property (weak,nonatomic) id <TaskViewControllerDelegate> delegate;
@property (strong,nonatomic) Task *task;
@property (strong, nonatomic) IBOutlet UILabel *infoTaskLabel;
@property (strong, nonatomic) IBOutlet UILabel *info1TaskLabel;
@property (strong, nonatomic) IBOutlet UILabel *info2TaskLabel;
- (IBAction)editTask:(UIBarButtonItem *)sender;

@end
