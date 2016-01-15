# Switch - iOS (Objective-C)

`Switch` is a `UIControl` subclass that creates a UISwitch like control with provided image.

## Requirements
* iOS 6.0 or later
* QuartzCore.framework
* ARC (either project has ARC ON or Switch is compiled with `-fobjc-arc`)

## Installation
* Like to go with CocoaPods, add following to your podfile-
```
pod 'Switch'
```

* If you wish to copy the source files directly, that's up to you.

## How To Use
Using Switch is quite simple :
```objective-c
UIImage* image = [UIImage imageNamed:@"switch.png"];
Switch* mySwitch = [Switch switchWithImage:image visibleWidth:200 visibleWidthViewImageRatio:1];
[mySwitch addTarget:self action:@selector(switchToggled:) forControlEvents:UIControlEventValueChanged];
[self.view addSubview:mySwitch];
```

* Switch uses the image and visible width combination to toggle between states.
* Use visibleWidthViewImageRatio = 1 if image visible width corresponds to the expected view width in pixels. Otherwise pass ratio calculated as [expected view width] / visibleWidth
* You can provide cornerRadius of your choice to make it appear roundedCorner style or any other.

## What's the catch ?
#### It's the simplest, yet the appearance is all yours!
You can provide any image, just one complete image containing ON-THUMB-OFF (see image below) both states
(for reference, see `SwitchArtwork` in demo app) 
and visibleWidth to toggle between states, and that's it.

All that appearance depends on how creative your artwork is.
A typical expected Switch image must be of form :-
![SwitchImage] (https://raw.githubusercontent.com/taruntyagi697/Switch/master/Example/SwitchDemo/SwitchArtwork/switch9.png)

## How It Looks
![Screenshot1] (https://raw.githubusercontent.com/taruntyagi697/Switch/master/Screenshots/Screenshot1.png)
![Screenshot2] (https://raw.githubusercontent.com/taruntyagi697/Switch/master/Screenshots/Screenshot2.png)

    
## Demo App
    Demo app includes an example just for reference.