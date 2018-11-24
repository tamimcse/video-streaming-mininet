sudo gst-launch-1.0 v4l2src device=/dev/video0 num-buffers=900 ! video/x-raw, framerate=30/1, width=1280, height=720 ! x264enc bitrate=2048 ! tcpserversink host=$1 port=8554 &
#sudo gst-launch-1.0 v4l2src device=/dev/video0 num-buffers=900 ! video/x-raw, framerate=30/1, width=1280, height=720 ! x264enc bitrate=2048  ! rtph264pay ! udpsink host=127.0.0.1 &

