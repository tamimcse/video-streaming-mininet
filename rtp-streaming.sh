gst-launch-1.0  udpsrc port=8554 caps="application/x-rtp,payload=96" ! rtph264depay ! decodebin ! autovideosink &
