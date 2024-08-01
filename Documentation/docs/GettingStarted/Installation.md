### Installing TcEventVideoPlayback

There are four different parts of the project that are installed by default:

**TwinCAT PLC Libraries**

Installs the required SPT_Base, SPT_Event_Logger, and SPT_Vision libraries to hard disk and imports them into the PLC library repository

**TwinCAT HMI Control**

Installs the EventVideo HMI Control for playback of videos inside Tc HMI

**TwinCAT Sample Projects**

Installs the Quick Start sample projects. Located at ```TwinCAT\Functions\TcEventVideoPlayback```.

**TcEventVideoPlayback Windows Service**

Installs the Windows Background Worker service for converting images to video files and storing locally

<img src="../Images/Installer.png" alt="Install" style="zoom: 150%;" />




### Installing Runtime Only

This is what you would select for a TwinCAT XAR only system. Only the service is required to be installed and it will run in the background.



<img src="../Images/InstallerRuntimeOnly.png" alt="Runtime Only Install" style="zoom: 150%;" />



### Installer Notes

The sample projects, HMI nuget package, and PLC libraries will be installed wherever the user selects for the install process. However, the samples will also be located under ```TwinCAT\Functions\TcEventVideoPlayback``` directory.

The installer internally calls the RepTool to install the PLC libraries for you if a PLC XAE profile is available. The installer will also install the HMI nuget package inside the TE2000 resources directory.

