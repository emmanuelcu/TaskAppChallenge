//
//  ViewController.h
//  TaskAppChallenge
//
//  Created by Emmanuel Cuevas on 9/19/15.
//  Copyright © 2015 Emmanuel Cuevas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (IBAction)reorderTaskButton:(UIBarButtonItem *)sender;
- (IBAction)addTaskButtonVC:(UIBarButtonItem *)sender;
@property (strong, nonatomic) IBOutlet UITableView *showTasksTableView;

@end

