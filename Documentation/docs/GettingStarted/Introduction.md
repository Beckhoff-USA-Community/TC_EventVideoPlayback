
# Introduction

This site serves as reference documentation for the TwinCAT Event Video Playback Project.

#### What is TcEventVideoPlayback and why would I use it?

Great question! TcEventVideoPlayback provides and easy to use function for transforming cyclical images captured by TwinCAT Vision into video files based on a trigger input. These video files are logged to the internal Event Logger and can be played back with the included TwinCAT HMI control.

**Example:** Lets say you keep having a machine down occurrence on a production machine. You already have an inspection camera installed, but you would like a way to see what is going on and why this keeps happening. In comes TcEventVideoPlayback... With a simple PLC function block, once the event occurs all of the images from the inspection camera are combined into a video file. This video file is then stored locally, and can be played back on our HMI along with the corresponding alarm.



### Additional Resources

- [TC_EventVideoPlayback Github](https://github.com/Beckhoff-USA-Community/TC_EventVideoPlayback)
