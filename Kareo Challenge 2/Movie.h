//
//  Movie.h
//  Kareo Challenge 2
//
//  Created by Jeff More on 7/16/14.
//
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property (strong) NSDictionary *json;
@property (strong) UIImage *poster;
@property (assign) bool posterLoaded;


- (id)initWithJSONDict:(NSDictionary*)jsonDict;
- (NSString*)getValue:(NSString*)key;

@end
