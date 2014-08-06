//
//  MAGViewController.m
//  InstaGrab
//
//  Created by Jesse Allison on 8/1/14.
//  Copyright (c) 2014 MAG. All rights reserved.
//

#import "MAGViewController.h"

@interface MAGViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *pictureDisplay;
@property (strong, nonatomic) UIImage *currentPic;
- (IBAction)sendTweet:(id)sender;

- (IBAction)longPressTweet:(id)sender;

@end

@implementation MAGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self pictureDisplay].image = [UIImage imageNamed:@"InstaGrab.png"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([@"choosePhoto" isEqualToString:segue.identifier])
    {
        UIImagePickerController *controller = [[segue destinationViewController] init];
        controller.delegate = self;
        controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    if([@"takePhoto" isEqualToString:segue.identifier])
    {
        UIImagePickerController *controller = [[segue destinationViewController] init];
        controller.delegate = self;
        controller.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        // [[segue destinationViewController] setDelegate:self];
        // [[segue destinationViewController] setSourceType:UIImagePickerControllerSourceTypeCamera];
        
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *pic = [info valueForKey:UIImagePickerControllerOriginalImage];
        //------- Image Processing -------//
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *ciPic = [CIImage imageWithCGImage:pic.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone" keysAndValues:@"inputImage", ciPic, @"inputIntensity", @0.8f, nil];
    CIImage *filteredPic = [filter outputImage];
    CGImageRef cgimg = [context createCGImage:filteredPic
                                     fromRect:[filteredPic extent]];
    UIImage *processedPic = [UIImage imageWithCGImage:cgimg
                                                scale:1.0
                                          orientation:[pic imageOrientation]];
    self.currentPic = processedPic;
    [self pictureDisplay].image = processedPic;
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)sendTweet:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetView = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetView setInitialText:@"cct rocks! #ios_abc"];
        [tweetView addImage:self.currentPic];
        [self presentViewController:tweetView animated:YES completion:NULL];
    }
}

@end



