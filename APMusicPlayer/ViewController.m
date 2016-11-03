//
//  ViewController.m
//  APMusicPlayer
//
//  Created by Mac on 12/08/1938 Saka.
//  Copyright © 1938 Saka Aksh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    isPlaying = false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(BOOL)initializeAudioPlayer{
    
    BOOL status =false;
    
    NSURL *musicURL = [[NSBundle mainBundle]URLForResource:@"MyHeartWillGoOn" withExtension:@"mp3"];
    
    if (musicURL!=nil) {
    
      NSError *error;
      audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:musicURL error:&error];
        if (error!= nil) {
            NSLog(@"%@",error.localizedDescription);
        }
        else{
            status = true;
        }
        
    }
    
    return status;
}

- (IBAction)playAction:(id)sender {
    
    UIButton *button = sender;
    
    if([button.titleLabel.text isEqualToString:@"Play"]){
    
        if (isPlaying) {
            
            [audioPlayer play];

        }
        else{
            if ([self initializeAudioPlayer]) {
                [audioPlayer play];
                
                isPlaying = true;
                
            }
            else{
                NSLog(@"Something went wrong while initializing audio player");
            }
            
        }
    
         [button setTitle:@"Pause" forState:UIControlStateNormal];
        
    }
    else if([button.titleLabel.text isEqualToString:@"Pause"]){
        
        [audioPlayer pause];
        
        [button setTitle:@"Play" forState:UIControlStateNormal];
    }

}

- (IBAction)stopAction:(id)sender {
   
    [audioPlayer stop];
    
    isPlaying = false;
    [self.playButton setTitle:@"Play" forState:UIControlStateNormal];
    
}
@end
