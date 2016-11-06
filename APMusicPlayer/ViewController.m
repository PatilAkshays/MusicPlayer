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
    
    self.durationSlider.userInteractionEnabled = NO;
    
    self.durationSlider.minimumValue = 0;
    
    self.durationSlider.value= 0;
    
    [self.durationSlider setThumbImage:[UIImage imageNamed:@"thumb"] forState:UIControlStateNormal];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)updateDurationSlider {
    
    if (self.durationSlider.value == audioPlayer.duration) {
        
        timer = nil;
    }

    self.durationSlider.value = audioPlayer.currentTime;
    
    NSTimeInterval currentTime = self->audioPlayer.currentTime;
    
    NSInteger minutes = floor(currentTime/60);
    NSInteger seconds = trunc(currentTime - minutes * 60);
    
    // update your UI with currentTime;
     startDuration = [NSString stringWithFormat:@"%ld:%02ld", (long)minutes, (long)seconds];
    
    self.startTime.text= startDuration;
    
    NSTimeInterval durationTime = self->audioPlayer.duration;
    
    NSInteger minutesDuration = floor(durationTime/60);
    NSInteger secondsDuration = trunc(durationTime - minutes * 60);
    
    // update your UI with duration time;
    self.endTime.text = [NSString stringWithFormat:@"%ld:%2ld", (long)minutesDuration, (long)secondsDuration];
}



-(BOOL)initializeAudioPlayer{
    
    BOOL status =false;
    
   // NSURL *musicURL = [[NSBundle mainBundle]URLForResource:@"IWannaLoveYou" withExtension:@"mp3"];
    
    NSURL *musicURL = [[NSBundle mainBundle]URLForResource:@"myMusic" withExtension:@"mp3"];

    if (musicURL!=nil) {
    
      NSError *error;
      audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:musicURL error:&error];
        if (error!= nil) {
            NSLog(@"%@",error.localizedDescription);
        }
        else{
       
            [self getArtWorkWithFile:musicURL];

            self.durationSlider.maximumValue = audioPlayer.duration;
            
            status = true;
        }
        
    }
        return status;
}


-(void)getArtWorkWithFile:(NSURL *)myURL {
    
    AVAsset *asset = [AVURLAsset URLAssetWithURL:myURL options:nil];
    
    
   // float duration = audioPlayer.duration;

    
    NSArray *metaDataArray = [asset commonMetadata];
    
    for (AVMetadataItem *item in metaDataArray) {
        
        if ([[item commonKey] isEqualToString:@"title"]) {
            
            title = (NSString *)[item value];
        }
        else{
            self.labelTitle.text= [NSString stringWithFormat:@"Unknown Tracks"];

            
        }
        if ([[item commonKey] isEqualToString:@"artist"]) {
            
            artists= (NSString *)[item value];
        }
        else{
            self.labelArtist.text= [NSString stringWithFormat:@"Unknown Tracks"];
            
        }
        //        if ([[item commonKey] isEqualToString:@"albumName"]) {
        //
        //            album= (NSString *)[item value];
        //        }
        
        self.labelTitle.text= title;
        self.labelArtist.text = artists;
        
    }
    
    NSArray *keys = [NSArray arrayWithObjects:@"commonMetadata", nil];
    [asset loadValuesAsynchronouslyForKeys:keys completionHandler:^{
        NSArray *artworks = [AVMetadataItem metadataItemsFromArray:asset.commonMetadata
                                                           withKey:AVMetadataCommonKeyArtwork
                                                          keySpace:AVMetadataKeySpaceCommon];
        
        for (AVMetadataItem *item in artworks) {
            if ([item.keySpace isEqualToString:AVMetadataKeySpaceID3]) {
                //  NSDictionary *dict = [item.value copyWithZone:nil];
                
                NSData *data = [item.value copyWithZone:nil];
                
                UIImage *image = [UIImage imageWithData:data];
                
                self.artWorkImageView.image = image;
                
                self.iconImageView.image = image;
                
            } else if ([item.keySpace isEqualToString:AVMetadataKeySpaceiTunes]) {
                
                self.artWorkImageView.image = [UIImage imageWithData:[item.value copyWithZone:nil]];
                
                self.iconImageView.image = [UIImage imageWithData:[item.value copyWithZone:nil]];
                
            }
        }
    }];

}


-(void)startTimer {
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(updateDurationSlider) userInfo:nil repeats:YES];
    
    
}
- (IBAction)playAction:(id)sender {
    
    UIButton *button = sender;
    
    //if([button.titleLabel.text isEqualToString:@"Play"]){
    
    if (button.tag == 101) {
        
        if (isPlaying) {
            
            [audioPlayer play];

            [self startTimer];
        }
        else{
            if ([self initializeAudioPlayer]) {
                [audioPlayer play];
                [self startTimer];
                isPlaying = true;
                
            }
            else{
                NSLog(@"Something went wrong while initializing audio player");
            }
            
        }
    
        [button setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];

         //[button setTitle:@"Pause" forState:UIControlStateNormal];
          button.tag = 102;
    }
    //else if([button.titleLabel.text isEqualToString:@"Pause"]){
    else if (button.tag == 102){
        
        [audioPlayer pause];
        [timer invalidate];
        
      //  [button setTitle:@"Play" forState:UIControlStateNormal];
        
        [button setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        
        button.tag = 101;
    }

}

- (IBAction)stopAction:(id)sender {
   
    [audioPlayer stop];
    
    isPlaying = false;
    
    self.durationSlider.value = 0;
    [timer invalidate];
    timer= nil;
    
   // [self.playButton setTitle:@"play" forState:UIControlStateNormal];
    [self.playButton setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    self.playButton.tag = 101;

}



- (IBAction)forwordAction:(id)sender {
    
    if (_playButton.tag == 102) {

    NSTimeInterval currentTime = self->audioPlayer.currentTime;
    
    NSInteger timeToForward = floor(5);

    currentTime = currentTime + timeToForward;
    [audioPlayer setCurrentTime:currentTime];
    [audioPlayer play];
    }
    else{
        NSLog(@"Not Found");
    }

}
- (IBAction)backwordAction:(id)sender {
    
    if (_playButton.tag == 102) {
        
      NSTimeInterval currentTime = self->audioPlayer.currentTime;
    
      NSInteger timeToForward = floor(5);
    
       currentTime = currentTime - timeToForward;
      [audioPlayer setCurrentTime:currentTime];
      [audioPlayer play];
    }
   else{
        NSLog(@"Not Found");
    }

}

- (IBAction)repeatAction:(id)sender {
}
@end
