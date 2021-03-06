# <img src="https://user-images.githubusercontent.com/71535143/122158875-58044800-ce3b-11eb-86e6-2d73da06b34d.png" height="70"> ARgami
Providing interactive origami tutorial with AR instructions

Clone the repo and change the provisioning profile and app bundle id to build ARgami on your device!

## Supports Light and Dark mode

<img src="https://user-images.githubusercontent.com/71535143/118583538-3abc5b00-b763-11eb-825c-4b48a64f0c06.jpg" height="450"> <img src="https://user-images.githubusercontent.com/71535143/118583539-3b54f180-b763-11eb-8064-80f4f1c78ef6.jpg" height="450">

## Navigate through the app and find the origami that you fancy the most

<img src="https://user-images.githubusercontent.com/71535143/118585153-52491300-b766-11eb-9c3a-0690dfa456be.jpeg" height="450"> <img src="https://user-images.githubusercontent.com/71535143/118585154-52e1a980-b766-11eb-9d53-1ad1469d5476.jpeg" height="450">

## Click on *Need help?*

1. Click on any part of the screen to start the rectangle detection
1. When the correct rectangle is detected, touch inside the rectangular outline to create the overlay 
1. Enjoy the wonders of AR technology

<img src="https://user-images.githubusercontent.com/71535143/118597594-e2915300-b77a-11eb-80eb-3fdbf7a4967c.jpeg" height="450"> <img src="https://user-images.githubusercontent.com/71535143/118597588-e1602600-b77a-11eb-9a90-1c26513360d2.jpeg" height="450"> <img src="https://user-images.githubusercontent.com/71535143/118597592-e1f8bc80-b77a-11eb-81da-070c95ff0caa.jpeg" height="450">
### Video demo
https://user-images.githubusercontent.com/71535143/118597596-e2915300-b77a-11eb-8190-8f46f226ab3d.mp4

### TODO
1. Migrate to openCV for a more felexible camera vision technology
2. Support detection of any polygons (given number of sides and the ratio of the sizes)
3. Have origami turtorial data stored on cloud (S3 bucket) and fetched in the app

### Special Thanks
To Mel Ludowise for a huge help in creating AR scene nodes with rectangle detection.
Please refer to https://github.com/mludowise/ARKitRectangleDetection for original code for rectangle detection in ARSCNView

