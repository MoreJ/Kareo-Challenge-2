//
//  AppDelegate.m
//  Kareo Challenge 2
//
//  Created by Jeff More on 7/15/14.
//
//

#import "AppDelegate.h"
#import "MasterViewController.h"
#import "Movie.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    //Get List Data
    __block NSMutableArray *movies = [[NSMutableArray alloc] init];
    
    
    UINavigationController *navController = (UINavigationController *) self.window.rootViewController;
    __block MasterViewController *masterController = [navController.viewControllers objectAtIndex:0];
    masterController.movies = movies;

    
    
    //Initial Query
    [self grabAPIResults:@"s=Matrix":
     ^(NSDictionary *resultDict){
         
         NSArray *searchArr = [resultDict objectForKey:@"Search"];
         
         __block int response = 0;
         
         //Loop through Search Results
         for(int i=0;i<[searchArr count];i++)
         {
             //Grab Data and add Movie to Array
             [self grabAPIResults:
              [NSString stringWithFormat:@"i=%@",[[searchArr objectAtIndex:i]objectForKey:@"imdbID"]]:
              ^(NSDictionary *mDict){
                  Movie *m = [[Movie alloc] initWithJSONDict:mDict];
                  [movies addObject:m];
                  response++;
              }
              ];
             
         }
         
         while(response < [searchArr count]);
         
         //Refresh movie list data
         dispatch_async(dispatch_get_main_queue(), ^{
             [masterController.tableView reloadData];
         });

     }
     ];
    
    return YES;
}

- (void)grabAPIResults:(NSString *)query :(void(^)(NSDictionary * resultDict))completeBlock
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        
        //Grab JSON data from example search
        NSError *error = nil;
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.omdbapi.com/?%@",query]];
        NSString *jsonString = [NSString stringWithContentsOfURL:url
                                                        encoding:NSUTF8StringEncoding
                                                           error:&error];
        
        if(!error) {
            NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                     options:kNilOptions
                                                                       error:&error];
            
            if(completeBlock)completeBlock(jsonDict);
            
        }
    });
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
