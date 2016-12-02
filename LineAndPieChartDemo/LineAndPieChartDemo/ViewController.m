//
//  ViewController.m
//  LineAndPieChartDemo
//
//  Created by Krishana on 6/22/16.
//  Copyright © 2016 Konstant Info Solutions Pvt. Ltd. All rights reserved.
//

#import "ViewController.h"
@import Contacts;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

    
    CNContactStore *store = [[CNContactStore alloc] init];
    

    
    [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error)
     {
         // make sure the user granted us access
         if (!granted)
         {
            return;
         }
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addressBookDidChange:) name:CNContactStoreDidChangeNotification object:nil];
     }];

}

-(void) addressBookDidChange:(NSNotification *)notification
{
    NSLog(@"noti->%@",notification);
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
