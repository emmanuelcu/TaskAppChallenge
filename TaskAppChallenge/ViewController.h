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
#import "TaskViewController.h"



@interface ViewController : UIViewController < AddTaskViewControllerDelegate, UITableViewDataSource, UITableViewDelegate, TaskViewControllerDelegate>

- (IBAction)reorderTaskButton:(UIBarButtonItem *)sender;
- (IBAction)addTaskButtonVC:(UIBarButtonItem *)sender;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *taskObjects;

@end

