//
//  ViewController.h
//  tableRefresh
//
//  Created by satheesh on 6/2/15.
//  Copyright (c) 2015 mawaqaa. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mTableView;

-(void)reloadTableView;
-(void)CallingService;

-(NSString *)getHTTPCorrectedURLFromUrl:(NSString *)urlString;
-(BOOL)isValid:(id)sender;
@end

