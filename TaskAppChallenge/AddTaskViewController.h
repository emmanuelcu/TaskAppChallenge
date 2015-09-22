//
//  AddTaskViewController.h
//  TaskAppChallenge
//
//  Created by Emmanuel Cuevas on 9/19/15.
//  Copyright © 2015 Emmanuel Cuevas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

@protocol AddTaskViewControllerDelegate <NSObject>

-(void)didCancel;
-(void)didAddTask : (Task *) task;

@end

@interface AddTaskViewController : UIViewController
@property (weak,nonatomic) id <AddTaskViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UITextField *addTaskLabel;
@property (strong, nonatomic) IBOutlet UITextView *addTaskTextView;
@property (strong, nonatomic) IBOutlet UIDatePicker *addTaskDatePicker;
- (IBAction)addTaskButton:(UIButton *)sender;
- (IBAction)cancelTaskButton:(UIButton *)sender;

@end
