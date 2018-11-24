gst-launch-1.0 filesrc location=/home/tamim/Linux/bbb.mp4  num-buffers=1800 ! decodebin ! videoconvert ! x264enc bitrate=512 ! tcpserversink host=$1 port=8554 &
#gst-launch-1.0 videotestsrc pattern=snow num-buffers=1800 ! video/x-raw, framerate=30/1, width=512, height=340 ! x264enc bitrate=512 ! tcpserversink host=$1 port=8554 &
#sudo gst-launch-1.0 v4l2src device=/dev/video0 num-buffers=3000 ! video/x-raw, framerate=30/1, width=1280, height=720 ! x264enc bitrate=2048 ! tcpserversink host=$1 port=8554 &
#gst-launch-1.0 videotestsrc pattern=snow num-buffers=900 ! video/x-raw, framerate=30/1, width=1024, height=680 ! x264enc bitrate=2048 ! rtph264pay ! udpsink host=127.0.0.1 &

