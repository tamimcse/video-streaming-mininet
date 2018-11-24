#!/usr/bin/python

import os,time,thread
import gi
import sys, getopt
gi.require_version('Gst', '1.0')
gi.require_version('Gtk', '3.0')
from gi.repository import Gst, GLib, GObject, Gtk
GObject.threads_init()
Gst.init(None)

host = sys.argv[1]
#pipeline_str = 'videotestsrc pattern=snow num-buffers=1800 ! video/x-raw, framerate=30/1, width=512, height=340 ! x264enc bitrate=512 ! tcpserversink host=' + host + ' port=8554'
#pipeline = Gst.parse_launch(pipeline)


#https://blogs.gnome.org/uraeus/2012/11/08/gstreamer-python-and-videomixing/

class CLI_Main:
    def __init__(self):    	
	self.pipeline = Gst.Pipeline()

	src = Gst.ElementFactory.make("videotestsrc","src")
	src.set_property('pattern', 'snow')
	src.set_property('num-buffers', 1800)

	cfilter = Gst.ElementFactory.make("capsfilter", "cfilter")
	caps = Gst.Caps.from_string("video/x-raw, framerate=30/1, width=512, height=340")
	cfilter.set_property("caps", caps)

	enc = Gst.ElementFactory.make("x264enc","enc")
	enc.set_property('bitrate', 512)

	svr = Gst.ElementFactory.make("tcpserversink","svr")
	svr.set_property('host', host)
	svr.set_property('port', 8554)

	self.pipeline.add(src)
	self.pipeline.add(cfilter)
	self.pipeline.add(enc)
	self.pipeline.add(svr)

	src.link(cfilter)
	cfilter.link(enc)
	enc.link(svr)

	if (not self.pipeline or not src or not cfilter or not enc or not svr):
	    print('Not all elements could be created.')
	    exit(-1)

        bus=self.pipeline.get_bus()
        bus.add_signal_watch()
        bus.connect("message",self.on_message)
    	    
    def on_message(self,bus,message):
	print 	
#        fmt = "B"*7+"I"*21
#        x = struct.unpack(fmt, s.getsockopt(socket.IPPROTO_TCP, socket.TCP_INFO, 92))
#	file = open('info.data','a')
#    	file.write(x+"\n")
#	file.close()

    def main(self):
	self.pipeline.set_state(Gst.State.PLAYING)

mainclass=CLI_Main()
thread.start_new_thread(mainclass.main,())
loop = GLib.MainLoop()
loop.run()

