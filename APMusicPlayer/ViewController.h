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
}
@property (strong, nonatomic) IBOutlet UIButton *playButton;

- (IBAction)playAction:(id)sender;


- (IBAction)stopAction:(id)sender;


@end

