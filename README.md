# Video-TX-via-USRP-OFDM-and-GNURadio
Repository for GNURadio flowcharts for video transmission via USRP, OFDM

## Tx and Rx commands for FFMPEG
Execute in the root folder where you have ffmpeg and x264.

* RX: `./ffplay -f h264 udp://127.0.0.1:1234`
* TX: `./ffmpeg -f v4l2 -i /dev/video0 -preset ultrafast -vcodec libx264 -tune zerolatency -b 900k -f h264 udp://127.0.0.1:1234`
> For good streams `./ffmpeg -f v4l2 -i /dev/video0 -preset ultrafast -vcodec libx264 -tune zerolatency -b 100k -f h264 -pix_fmt yuv420p udp://127.0.0.1:1234`