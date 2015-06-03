//
//  ViewController.m
//  tableRefresh
//
//  Created by satheesh on 6/2/15.
//  Copyright (c) 2015 mawaqaa. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "TableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "AsyncImageView.h"


@interface ViewController ()
{

    NSMutableArray * mArray;
    NSMutableArray * tableData;
    UIActivityIndicatorView * indicatorFooter;
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self CallingService];
    
  UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    
    [self.mTableView addSubview:refreshControl];
    
NSArray * marray = [NSArray arrayWithObjects:@"one",@"Two",@"Three",@"Four", nil];
   NSArray * reversed =  [[marray reverseObjectEnumerator]allObjects];
    NSLog(@"Reverse:%@",reversed);
    
    
}

- (void)refresh:(UIRefreshControl *)refreshControl {
    // Do your job, when done:
        if (tableData.count<=[mArray count]-1) {
    
      /* for (int i=3;i<[mArray count];i++) {
      
         
          
           
         
        
       [tableData addObject:[mArray objectAtIndex:i]];
        //[tableData sortedArrayUsingSelector:@selector(compare:)];
      
          [self reloadTableView];
    }*/
            if (tableData.count+1%9==0) {
                [refreshControl endRefreshing];
                return;
            }
            else
            {
                
             [tableData addObjectsFromArray:[mArray subarrayWithRange:NSMakeRange(tableData.count, 9)]];
                
            }
         
}
    
        
    
    
  
 
    [self reloadTableView];
    [refreshControl endRefreshing];
}






-(void)CallingService
{
    
   /* AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //  manager.securityPolicy.allowInvalidCertificates = YES;
    NSDictionary *parameters = @{@"lang_key": @"en"};
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager POST:@"http://kipcoadmin.mawaqaademo.com/service/API.svc/Category" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        mArray = [[responseObject objectForKey:@"List"]mutableCopy];
        tableData=[[NSMutableArray alloc]init];
        [tableData addObjectsFromArray:[mArray subarrayWithRange:NSMakeRange(0, 2)]];
       // tableData = (NSMutableArray *)[mArray subarrayWithRange:NSMakeRange(0, 3)];
        
      
         NSLog(@"JSON tableDataArray: %@", tableData);
        
        
        [self reloadTableView];
        
        NSLog(@"JSON Array: %@", mArray);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    
    }];*/
    
    
   /* AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:@"http://almithaq.mawaqaademo.com/AlMithaqService/API.svc/get_Offer_List" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // do whatever you'd like here; for example, if you want to convert
        // it to a string and log it, you might do something like:
        
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@", string);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];*/
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://almithaq.mawaqaademo11.com/API.svc/get_Offer_List" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        mArray = [[responseObject objectForKey:@"Offer_Stag1"]mutableCopy];
        tableData=[[NSMutableArray alloc]init];
        
        [tableData addObjectsFromArray:[mArray subarrayWithRange:NSMakeRange(0, 10)]];
    
        NSLog(@"JSON tableDataArray: %@", tableData);
        
        
        [self reloadTableView];
        
        NSLog(@"JSON Array: %@", mArray);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

-(void)reloadTableView
{
    [self.mTableView reloadData];
    


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   
        return 1;
  
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * identifier = @"identifier";
    TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.mSectionLbl.text = [[tableData objectAtIndex:indexPath.row]valueForKey:@"Section"];

    
  

    NSString *imageUrl = [self getHTTPCorrectedURLFromUrl:[[tableData objectAtIndex:indexPath.row]valueForKey:@"Images"]];
/*  [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:cell.mImageView];
     NSURL * url = [NSURL URLWithString:imageUrl];
     ((AsyncImageView *)cell.mImageView).imageURL = url;*/
    
  /*  NSURL *url = [NSURL URLWithString:imageUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    UIImage *placeholderImage = [UIImage imageNamed:@""];
    
    __weak UITableViewCell *weakCell = cell;
    
    [cell.mImageView setImageWithURLRequest:request
                           placeholderImage:placeholderImage
                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                        
                                        weakCell.imageView.image = image;
                                        [weakCell setNeedsLayout];
                                        
                                    } failure:nil];*/
    
    
    return cell;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * new = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 10)];
    return new;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 240;
}
-(NSString *)getHTTPCorrectedURLFromUrl:(NSString *)urlString
{
    NSString *correctedURLString;
    if ([self isValid:urlString])
    {
        if (urlString.length>0) {
            if (![urlString hasPrefix:@"http"])
            {
                correctedURLString = [NSString stringWithFormat:@"http://%@",urlString];
            }
            else
            {
                correctedURLString = urlString;
            }
        }
    }
    
    return correctedURLString;
}

-(BOOL)isValid:(id)sender
{
    BOOL valid = NO;
    if ((sender!=nil)&&(![sender isEqual:[NSNull null]]))
    {
        valid=YES;
    }
    return valid;
}
@end
