gst-launch-1.0 videotestsrc pattern=snow num-buffers=1800 ! video/x-raw, framerate=30/1, width=512, height=340 ! x264enc bitrate=512 ! rtph264pay ! udpsink host=$1 port=8554 &
#gst-launch-1.0  udpsrc port=8554 caps="application/x-rtp,payload=96" ! rtph264depay ! decodebin ! autovideosink

