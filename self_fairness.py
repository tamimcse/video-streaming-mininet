#!/usr/bin/python

"""
linuxrouter.py: Example network with Linux IP router

This example converts a Node into a router using IP forwarding
already built into Linux.


##############################################################################
# Topology with two switches and two hosts with static routes
#
#       172.16.101.0/24         172.16.10.0/24         172.16.102.0./24
#  h1 ------------------- r1 ------------------ r2------- -------------h2
#    .1                .2   .2               .3   .2                 .1
#
#       172.16.103.0/24         172.16.10.0/24         172.16.104.0./24
#  h3 ------------------- r1 ------------------ r2------- -------------h4
#    .1                .2   .2               .3   .2                 .1
#       172.16.105.0/24         172.16.10.0/24         172.16.106.0./24
#  h5 ------------------- r1 ------------------ r2------- -------------h6
#    .1                .2   .2               .3   .2                 .1

##############################################################################
"""


from mininet.topo import Topo
from mininet.net import Mininet
from mininet.node import Node
from mininet.link import TCLink
from mininet.node import CPULimitedHost
from mininet.log import setLogLevel, info
from mininet.cli import CLI
import sys
import time

class LinuxRouter( Node ):
    "A Node with IP forwarding enabled."

    def config( self, **params ):
        super( LinuxRouter, self).config( **params )
        # Enable forwarding on the router
        self.cmd( 'sysctl net.ipv4.ip_forward=1' )

    def terminate( self ):
        self.cmd( 'sysctl net.ipv4.ip_forward=0' )
        super( LinuxRouter, self ).terminate()


class NetworkTopo( Topo ):
    "A LinuxRouter connecting three IP subnets"

    def build( self, **_opts ):	
        h1 = self.addHost( 'h1', ip='172.16.101.1/24', defaultRoute='via 172.16.101.2' )
        h2 = self.addHost( 'h2', ip='172.16.102.1/24', defaultRoute='via 172.16.102.2' )

        h3 = self.addHost( 'h3', ip='172.16.103.1/24', defaultRoute='via 172.16.103.2' )
        h4 = self.addHost( 'h4', ip='172.16.104.1/24', defaultRoute='via 172.16.104.2' )

        h5 = self.addHost( 'h5', ip='172.16.105.1/24', defaultRoute='via 172.16.105.2' )
        h6 = self.addHost( 'h6', ip='172.16.106.1/24', defaultRoute='via 172.16.106.2' )

        r1 = self.addNode( 'r1', cls=LinuxRouter, ip='172.16.101.2/24' )
        r2 = self.addNode( 'r2', cls=LinuxRouter, ip='172.16.102.2/24' )

        self.addLink( h1, r1, intfName2='r1-eth2', params2={ 'ip' : '172.16.101.2/24' })
        self.addLink( h2, r2, intfName2='r2-eth2', params2={ 'ip' : '172.16.102.2/24' })
#       Don't move the line. It doesn't work for some reason
        self.addLink( r1, r2, intfName1='r1-eth1', params1={ 'ip' : '172.16.10.2/24' }, intfName2='r2-eth1', params2={ 'ip' : '172.16.10.3/24' })

        self.addLink( h3, r1, intfName2='r1-eth3', params2={ 'ip' : '172.16.103.2/24' })
        self.addLink( h4, r2, intfName2='r2-eth3', params2={ 'ip' : '172.16.104.2/24' })

        self.addLink( h5, r1, intfName2='r1-eth4', params2={ 'ip' : '172.16.105.2/24' })
        self.addLink( h6, r2, intfName2='r2-eth4', params2={ 'ip' : '172.16.106.2/24' })

def main(cli=0):
    "Test linux router"
    topo = NetworkTopo()
    net = Mininet( topo=topo, controller = None )
    net.start()

    isRTP = False

    queuing_del = '100ms'

    access_delay = '10ms'
    access_delay_var = '2ms'
    access_loss = '0.1%'
    #mbps = Mega Bytes per sec
    access_rate = '1024kbit' 

    bottleneck_delay = '50ms'
    bottleneck_delay_var = '3ms'
    bottleneck_loss = '0%' #'0.1%'
    #mbps = Mega Bytes per sec
    bottleneck_rate = '1024kbit'#'2048' for avoiding congestion

    info( '*** Configuring routers:\n' )
#    net[ 'r1' ].cmd( 'ip neigh add 172.16.10.3 lladdr 2e:a9:cf:14:b4:6a dev r1-eth1' )
    net[ 'r1' ].cmd( 'ip route add 172.16.102/24 nexthop via 172.16.10.3' )
    net[ 'r1' ].cmd( 'ip route add 172.16.104/24 nexthop via 172.16.10.3' )
    net[ 'r1' ].cmd( 'ip route add 172.16.106/24 nexthop via 172.16.10.3' )
    net[ 'r2' ].cmd( 'ip route add 172.16.101/24 nexthop via 172.16.10.2' )
    net[ 'r2' ].cmd( 'ip route add 172.16.103/24 nexthop via 172.16.10.2' )
    net[ 'r2' ].cmd( 'ip route add 172.16.105/24 nexthop via 172.16.10.2' )

    info( '*** Routing Table on Router:\n' )
    info( net[ 'r1' ].cmd( 'route' ) )

    hosts = ['h1', 'h2', 'h3', 'h4', 'h5', 'h6']
    for host in hosts:
	net[host].cmd( 'tc qdisc add dev {0}-eth0 root handle 1: tbf rate {1} latency {2} burst 1540'.format(host, access_rate, queuing_del))
	net[host].cmd( 'tc qdisc add dev {0}-eth0 parent 1:1 handle 10: netem delay {1} {2}'.format(host, access_delay, access_delay_var))
	net[host].cmd( 'tc qdisc add dev {0}-eth0 parent 10:  handle 101: fq'.format(host))
#	net[host].cmd( 'tc qdisc change dev {0}-eth0 root netem loss {1}'.format(host, access_loss))
#	net[host].cmd( 'tc -s qdisc show dev {0}-eth0'.format(host))

    routers = ['r1', 'r2']
    ifs = ['eth2 ', 'eth3 ', 'eth4']
    for router in routers:
    	for inf in ifs:
		net[router].cmd( 'tc qdisc add dev {0}-{1} root handle 1: tbf rate {2} latency {3} burst 1540'.format(router, inf, access_rate, queuing_del))
		net[router].cmd( 'tc qdisc add dev {0}-{1} parent 1:1 handle 10: netem delay {2} {3}'.format(router, inf, access_delay, access_delay_var))

    for router in ['r1']: 
	net[router].cmd( 'tc qdisc add dev {0}-eth1 clsact'.format(router))
	net[router].cmd( 'tc filter add dev {0}-eth1 ingress bpf da obj samples/bpf/mf.o sec mf'.format(router))
	net[router].cmd( 'tc qdisc add dev {0}-eth1 parent ffff: handle 2: htb default 10'.format(router))
	net[router].cmd( 'tc class add dev {0}-eth1 parent 2: classid 2:1 htb rate {1}'.format(router, bottleneck_rate))
	net[router].cmd( 'tc class add dev {0}-eth1 parent 2:1 classid 2:10 htb rate {1}'.format(router, bottleneck_rate))
	net[router].cmd( 'tc qdisc add dev {0}-eth1 parent 2:10 handle 10: netem delay {1} {2} loss {3}'.format(router, bottleneck_delay, bottleneck_delay_var, bottleneck_loss))
#	net[router].cmd( 'tc qdisc add dev {0}-eth1 parent 10: handle 101: codel'.format(router))	      

    for router in ['r2']:    	
	net[router].cmd( 'tc qdisc add dev {0}-eth1 root handle 1: htb default 10'.format(router))
	net[router].cmd( 'tc class add dev {0}-eth1 parent 1: classid 1:1 htb rate {1}'.format(router, bottleneck_rate))
	net[router].cmd( 'tc class add dev {0}-eth1 parent 1:1 classid 1:10 htb rate {1}'.format(router, bottleneck_rate))
	net[router].cmd( 'tc qdisc add dev {0}-eth1 parent 1:10 handle 10: netem delay {1} {2}'.format(router, bottleneck_delay, bottleneck_delay_var))	      


    #net.pingAll()

    hosts = [net['h1'], net['h2']]
        
    if cli:
        net.iperf(hosts, seconds=30, l4Type='UDP', udpBw='160M')
        CLI( net )
    elif isRTP:
	net[ 'h1' ].cmd( 'sudo sh rtp-streamer.sh  172.16.102.1' )
	net[ 'h2' ].cmd( 'sudo sh rtp-streaming.sh' )
	net[ 'h3' ].cmd( 'sudo sh rtp-streamer.sh  172.16.104.1 &' )
	net[ 'h4' ].cmd( 'sh rtp-streaming.sh' )
	net[ 'h5' ].cmd( 'sudo sh rtp-streamer.sh  172.16.106.1 &' )
	net[ 'h6' ].cmd( 'sh rtp-streaming.sh' )
#	net[ 'r1' ].cmd( 'watch  -dc  tc -s qdisc show dev r1-eth1' )
        CLI( net )
    else:
#	net[ 'h1' ].cmd( 'sudo sh nftest.sh &' )
	net[ 'h1' ].cmd( 'sudo ./streamer  172.16.101.1 &' )
	net[ 'h2' ].cmd( 'sh streaming.sh 172.16.101.1' )
#	time.sleep(15)
	net[ 'h3' ].cmd( 'sudo ./streamer  172.16.103.1 &' )
	net[ 'h4' ].cmd( 'sh streaming.sh 172.16.103.1' )
#	time.sleep(15)
	net[ 'h5' ].cmd( 'sudo ./streamer  172.16.105.1 &' )
	net[ 'h6' ].cmd( 'sh streaming.sh 172.16.105.1' )
#	net[ 'r1' ].cmd( 'watch  -dc  tc -s qdisc show dev r1-eth1' )
        CLI( net )
    net.stop()

if __name__ == '__main__':
    args = sys.argv
    setLogLevel( 'info' )
    cli = 0
    if "--cli" in args:
        cli = 1
    main(cli)
