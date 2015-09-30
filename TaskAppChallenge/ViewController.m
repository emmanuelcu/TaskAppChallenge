//
//  ViewController.m
//  TaskAppChallenge
//
//  Created by Emmanuel Cuevas on 9/19/15.
//  Copyright © 2015 Emmanuel Cuevas. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

//Lazy insitation to initiate an array. It must be a mutable array because we are going to be adding and removing tasks as our users adds and deletes them.

-(NSMutableArray *) taskObjects{
    if (!_taskObjects) {
        _taskObjects = [[NSMutableArray alloc] init];
        
    }
    return _taskObjects;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    NSArray *taskAsPropertyLists =[[NSUserDefaults standardUserDefaults] arrayForKey:TASK_OBJECT_KEY];
    for (NSDictionary *dictionary in taskAsPropertyLists){
        Task *taskObject = [self taskObjectForDictionary:dictionary];
        [self.taskObjects addObject:taskObject];
        
        self.showTasksTableView.delegate = self;
        self.showTasksTableView.dataSource = self;
    }
}


//Method to prepare the information to pass it to the addtask view controller

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if ([segue.destinationViewController isKindOfClass:[AddTaskViewController class]]) {
        AddTaskViewController *addTaskViewControllerObject = segue.destinationViewController;
        addTaskViewControllerObject.delegate=self;
    }

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)reorderTaskButton:(UIBarButtonItem *)sender {
}

- (IBAction)addTaskButtonVC:(UIBarButtonItem *)sender {
    
    [self performSegueWithIdentifier:@"toAddTaskViewController" sender:nil];
}

#pragma mark - AddTaskViewControllerDelegate

-(void)didAddTask:(Task *)task{
    
    [self.taskObjects addObject:task];
    NSLog(@"%@", task.title);

    NSMutableArray *taskObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:TASK_OBJECT_KEY] mutableCopy];
    
    if (!taskObjectsAsPropertyLists) taskObjectsAsPropertyLists = [[NSMutableArray alloc] init];
    
    //Creating the methos before finishing this task to property list
    
    [taskObjectsAsPropertyLists addObject: [self taskObjectsAsPropertyList:task]];
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectsAsPropertyLists forKey:TASK_OBJECT_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.showTasksTableView reloadData];
}


-(void)didCancel{
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

#pragma mark - Helper methods
    
    -(NSDictionary *)taskObjectsAsPropertyList:(Task *) taskObject{
    
        NSDictionary *dictionary = @{
                                     TASK_TITLE : taskObject.title,
                                     TASK_DESCRIPTION : taskObject.description,
                                     TASK_DATE : taskObject.date,
                                     TASK_COMPLETION : @(taskObject.isCompleted)
                                     };
        return dictionary;
    
    }

-(Task *)taskObjectForDictionary :(NSDictionary *)dictionary{
    
    Task *taskObject = [[Task alloc] initWithData:dictionary];
    return taskObject;

}

-(BOOL)isDateGreaterThanDate: (NSDate *)date and:(NSDate *)toDate{

    NSTimeInterval dateInterval = [date timeIntervalSince1970];
    NSTimeInterval toDateInterval = [toDate timeIntervalSince1970];
    
    if (dateInterval>toDateInterval) return YES;
    else return NO;

}

#pragma mark - UITAbleViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.taskObjects count];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Task *task = [self.taskObjects objectAtIndex:indexPath.row];
    cell.textLabel.text = task.title;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyy-MM-dd"];
    NSString *stringFromDate = [formatter stringFromDate:task.date];
    cell.detailTextLabel.text = stringFromDate;
    
    //configuring the color of the cell depending on the date
    
    BOOL isOverDue = [self isDateGreaterThanDate:[NSDate date] and:task.date];
    if (isOverDue==YES) cell.backgroundColor = [UIColor colorWithRed:255/255.0 green:11/255.0 blue:0/255.0 alpha:1];
    else cell.backgroundColor = [UIColor colorWithRed:67/255.0 green:237/255.0 blue:65/255.0 alpha:1];
    
    return cell;

}

@end
