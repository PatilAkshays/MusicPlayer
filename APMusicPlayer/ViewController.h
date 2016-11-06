//
//  ViewController.h
//  APMusicPlayer
//
//  Created by Mac on 12/08/1938 Saka.
//  Copyright © 1938 Saka Aksh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface ViewController : UIViewController

{
    AVAudioPlayer *audioPlayer;
    BOOL isPlaying;
   // NSURL *musicURL;
    
    NSString *title;
    NSString *artists;
    NSString *album;
    
    NSTimer *timer;
    
    NSString *startDuration;
}
@property (strong, nonatomic) IBOutlet UIButton *playButton;

@property (strong, nonatomic) IBOutlet UILabel *labelTitle;
@property (strong, nonatomic) IBOutlet UILabel *labelArtist;

@property (strong, nonatomic) IBOutlet UIImageView *artWorkImageView;
@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;

@property (strong, nonatomic) IBOutlet UISlider *durationSlider;

@property (strong, nonatomic) IBOutlet UILabel *startTime;

@property (strong, nonatomic) IBOutlet UILabel *endTime;

- (IBAction)playAction:(id)sender;
- (IBAction)stopAction:(id)sender;
- (IBAction)forwordAction:(id)sender;
- (IBAction)backwordAction:(id)sender;
- (IBAction)repeatAction:(id)sender;

@end

