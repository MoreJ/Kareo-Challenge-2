//
//  DetailViewController.m
//  Kareo Challenge 2
//
//  Created by Jeff More on 7/15/14.
//
//

#import "DetailViewController.h"
#import "Movie.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        Movie* selectedMovie = (Movie*)self.detailItem;
        self.title = [selectedMovie getValue:@"Title"];
        
        if([selectedMovie poster] != NULL)
        {
            self.poster.image = [selectedMovie poster];
        }
        
        self.description.text = [selectedMovie getValue:@"Plot"];
        self.date.text = [selectedMovie getValue:@"Released"];
        self.runtime.text = [selectedMovie getValue:@"Runtime"];
        self.rating.text = [NSString stringWithFormat:@"%@/10",[selectedMovie getValue:@"imdbRating"]];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
