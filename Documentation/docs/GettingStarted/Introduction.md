
# Introduction

This site serves as reference documentation for the TwinCAT Event Video Playback Project.

#### What is TcEventVideoPlayback and why would I use it?

Great question! TcEventVideoPlayback provides and easy to use function for transforming cyclical images captured by TwinCAT Vision into video files based on an event input. These video files are logged to the internal Event Logger and can be played back with the included TwinCAT HMI control.

**Example:** Let’s say you keep having a machine down occurrence on a production machine. You want to see what is going on and why this keeps happening. In comes TcEventVideoPlayback... 

With a TwinCAT enabled camera, and a simple PLC function block, your questions are answered. Images from the camera are continuously buffered. When an event occurs, an event is generated in the HMI Event Log. Then, images from before and after the event are converted to a video file on the hard disk. This video file is name time stamped to coordinate with the event generated in the HMI event log. Selecting the event in the log on the included TwinCAT HMI control, allows the associated video to be viewed.



### Additional Resources

- [TC_EventVideoPlayback Installer](https://github.com/Beckhoff-USA-Community/TC_EventVideoPlayback/releases)
- [TC_EventVideoPlayback Github](https://github.com/Beckhoff-USA-Community/TC_EventVideoPlayback)
