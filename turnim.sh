is_mf=$(cat /proc/sys/net/ipv4/tcp_mf)
is_xcp=$(cat /proc/sys/net/ipv4/tcp_xcp)
cong=$(cat /proc/sys/net/ipv4/tcp_congestion_control)
echo $is_mf
echo $is_xcp
echo $cong

if [ $is_mf -eq '1' ] && [ $is_xcp -eq '0' ]
then
    sudo sysctl net.ipv4.tcp_xcp=1
elif [ $is_xcp -eq '1' ]
then
    sudo sysctl net.ipv4.tcp_mf=0
    sudo sysctl net.ipv4.tcp_xcp=0
    sudo sysctl net.ipv4.tcp_congestion_control=cdg
elif [ $cong = "cdg" ]
then
    sudo sysctl net.ipv4.tcp_rcv_cc_fairness=1
    sudo sysctl net.ipv4.tcp_rcv_congestion_control=1
    sudo sysctl net.ipv4.tcp_congestion_control=inigo
else
    sudo sysctl net.ipv4.tcp_rcv_cc_fairness=0
    sudo sysctl net.ipv4.tcp_rcv_congestion_control=0
    sudo sysctl net.ipv4.tcp_mf=1
    sudo sysctl net.ipv4.tcp_congestion_control=cubic
fi

