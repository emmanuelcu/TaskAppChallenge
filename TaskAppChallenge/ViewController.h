//
//  ViewController.h
//  TaskAppChallenge
//
//  Created by Emmanuel Cuevas on 9/19/15.
//  Copyright © 2015 Emmanuel Cuevas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddTaskViewController.h"
#import "Task.h"


@interface ViewController : UIViewController < AddTaskViewControllerDelegate, UITableViewDataSource, UITextFieldDelegate>

- (IBAction)reorderTaskButton:(UIBarButtonItem *)sender;
- (IBAction)addTaskButtonVC:(UIBarButtonItem *)sender;
@property (strong, nonatomic) IBOutlet UITableView *showTasksTableView;
@property (strong, nonatomic) NSMutableArray *taskObjects;

@end

