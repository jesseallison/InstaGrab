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
    [self pictureDisplay].image = pic;
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

@end
