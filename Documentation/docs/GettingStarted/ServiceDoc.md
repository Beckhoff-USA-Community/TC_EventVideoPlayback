
# Service Documentation


## Service Configuration

To configure the service, you must first stop it from running. You can do this by opening the Windows Services window -> Right-clicking the TcEventVideoPlayback service -> Stop Service.

The config file is located at ```C:\Program Files\Beckhoff Automation LLC\TcEventVideoPlayback\TcEventVideoPlaybackService\TcEventVideoPlaybackService.config```

Open the file with notepad or Visual Studio and you will see the following parameters

```json
{
  "CodecFourCC": "avc1",
  "VideoDeleteTime": 1,
  "AdsPort": 26129
}
```

#### CodecFourCC

This is the codec used to create the video from the service. avc1 is the most common codec that is also compatible with web browsers. For a full list of codecs see below, but not all are web compatible and will display as a black box on Tc HMI. [Check here for appropriate codecs](https://developer.mozilla.org/en-US/docs/Web/Media/Formats/Video_codecs).

```
OpenCV: FFMPEG: format mp4 / MP4 (MPEG-4 Part 14)
fourcc tag 0x7634706d/'mp4v' codec_id 000C
fourcc tag 0x31637661/'avc1' codec_id 001B
fourcc tag 0x33637661/'avc3' codec_id 001B
fourcc tag 0x31766568/'hev1' codec_id 00AD
fourcc tag 0x31637668/'hvc1' codec_id 00AD
fourcc tag 0x7634706d/'mp4v' codec_id 0002
fourcc tag 0x7634706d/'mp4v' codec_id 0001
fourcc tag 0x7634706d/'mp4v' codec_id 0007
fourcc tag 0x7634706d/'mp4v' codec_id 003D
fourcc tag 0x7634706d/'mp4v' codec_id 0058
fourcc tag 0x312d6376/'vc-1' codec_id 0046
fourcc tag 0x63617264/'drac' codec_id 0074
fourcc tag 0x7634706d/'mp4v' codec_id 00A3
fourcc tag 0x39307076/'vp09' codec_id 00A7
fourcc tag 0x31307661/'av01' codec_id 801D
fourcc tag 0x6134706d/'mp4a' codec_id 15002
fourcc tag 0x63616c61/'alac' codec_id 15010
fourcc tag 0x6134706d/'mp4a' codec_id 1502D
fourcc tag 0x6134706d/'mp4a' codec_id 15001
fourcc tag 0x6134706d/'mp4a' codec_id 15000
fourcc tag 0x332d6361/'ac-3' codec_id 15003
fourcc tag 0x332d6365/'ec-3' codec_id 15028
fourcc tag 0x6134706d/'mp4a' codec_id 15004
fourcc tag 0x61706c6d/'mlpa' codec_id 1502C
fourcc tag 0x43614c66/'fLaC' codec_id 1500C
fourcc tag 0x7375704f/'Opus' codec_id 1503C
fourcc tag 0x6134706d/'mp4a' codec_id 15005
fourcc tag 0x6134706d/'mp4a' codec_id 15018
fourcc tag 0x6134706d/'mp4a' codec_id 15803
fourcc tag 0x7334706d/'mp4s' codec_id 17000
fourcc tag 0x67337874/'tx3g' codec_id 17005
fourcc tag 0x646d7067/'gpmd' codec_id 18807
fourcc tag 0x316d686d/'mhm1' codec_id 15817
```

#### VideoDeleteTime

This is the amount of time that the file will stay stored on the system. If the time expired, the service will automatically cleanup old video files.

The value is a floating point value, and is in units of Days. So for half a day you will need to put 0.5 as the value.

#### AdsPort

This is the ADS Port that the service is hosting on. This should remaing at port 26129 at all times in order for the PLC function blocks to work properly.
