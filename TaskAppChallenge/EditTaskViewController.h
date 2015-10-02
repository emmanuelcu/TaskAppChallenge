//
//  EditTaskViewController.h
//  TaskAppChallenge
//
//  Created by Emmanuel Cuevas on 9/19/15.
//  Copyright © 2015 Emmanuel Cuevas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

@protocol EditTaskViewControllerDelegate <NSObject>

-(void)didUpdateTask;

@end

@interface EditTaskViewController : UIViewController <UITextFieldDelegate,UITextViewDelegate>
- (IBAction)saveEditedTaskButton:(UIBarButtonItem *)sender;
@property (weak,nonatomic) id <EditTaskViewControllerDelegate> delegate;
@property (strong,nonatomic) Task *task;
@property (strong, nonatomic) IBOutlet UITextField *editedTaskLabel;
@property (strong, nonatomic) IBOutlet UITextView *editedTextView;
@property (strong, nonatomic) IBOutlet UIDatePicker *editedDatePicker;

@end
