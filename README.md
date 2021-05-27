It contains Mininet (http://mininet.org/) scripts to evaluate NC-TCP, XCP and TCP Inigo for video streaming. The details of the experiment will be found in the following paper:

```
A Network-centric TCP for Interactive Video Delivery Networks (VDN)
MD Iftakharul Islam, Javed I Khan
IEEE ICNP Workshop PVE-SDN, 2017.
```


* mininet.sh : Creates a single bottlenek topology in Mininet. It simply calls `router.py`.
* router.py  : The actual mininet script that creates a single bottleneck topology described in the paper. It runs a video streaming source `gst-streamer`(https://github.com/tamimcse/gst-streamer) on the source nodes and video streaming clients `streaming.sh` on the video streaming client nodes.

* parkinglot.sh : Creates a multiple bottlenek topology in Mininet. It simply calls `parkinglot.py`.
* parkinglot.py : The actual miininet script that creates a parking lot topology described in the paper. It runs a video streaming source `gst-streamer`(https://github.com/tamimcse/gst-streamer) on the source nodes  and video streaming clients `streaming.sh` on the video streaming client nodes.

* rtt.sh : Creates a single bottleneck topology where with different RTTs among the sources and destinations (details are also described in paper).
* router_rtt.py : Actual mininet script used by rtt.sh

* self_fainess.py : The mininet script test self-fairness as described in the paper. Here instead of starting video conferencing simultaniously, each host starts the video conferencing after 15 sec from the previous host. 

All these scripts also internally uses some other scripts. 

* cam_streamer.sh : Captures webcam and stream the video. It can be used as an alternative to `gst-streamer`(https://github.com/tamimcse/gst-streamer) which stream a video file.
* bbb.mp4 : A clip from `Big Buck Bunny` which is streamed by `gst-streamer` in the experiment.
* cubic.sh : It sets the congestion control algorithm to TCP CUBIC

* movedata.sh : `mininet.sh`, `parkinglot.sh` and `rtt.sh` uses `tcpprobe` kernel module to record improtant data such as latency, throuput and so on. `movedata.sh` moves the data to experiment folder.

* rtp-streamer.sh : Calls `rtp-streaming.py`
* rtp-streaming.py : Uses RTP for video streaming instead of TCP

