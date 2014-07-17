//
//  Movie.m
//  Kareo Challenge 2
//
//  Created by Jeff More on 7/16/14.
//
//

#import "Movie.h"

@implementation Movie


- (id)initWithJSONDict:(NSDictionary*)jsonDict
{
    if ((self = [super init])) {
        self.json = jsonDict;
        self.posterLoaded = false;
        
        
        dispatch_queue_t img_queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(img_queue, ^{
            
            NSURL *url = [NSURL URLWithString:[self getValue:@"Poster"]];
            NSError *error = nil;
            NSData *image = [NSData dataWithContentsOfURL:url options:0 error:&error];
            
            if(!error && image && [image length] > 0) {
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
                NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"image.png"];
                
                [image writeToFile:path options:0 error:&error];              
            }
            self.poster = [UIImage imageWithData:image];
            self.posterLoaded = true;
        });
        
        
    }
    return self;
}

- (NSString*)getValue:(NSString*)key
{
    return [self.json objectForKey:key];
}

@end
