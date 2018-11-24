gst-launch-1.0  tcpclientsrc host=$1 port=8554 ! h264parse ! avdec_h264 ! xvimagesink &
#gst-launch-1.0  tcpclientsrc host=$1 port=8554 ! h264parse ! avdec_h264 ! mpegtsmux ! filesink location=test.ts &
#gst-launch-1.0  udpsrc ! application/x-rtp,payload=96 ! rtph264depay ! decodebin ! xvimagesink &
