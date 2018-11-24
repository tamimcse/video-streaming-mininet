#Install Chrome first manually
#F10: BIOS, F9: advanced boot, sometimes I had to hold the key down to get it to work
#sudo apt-get -f install &&
sudo apt-get install -y git subversion &&
sudo apt-get install -y netperf inetutils-traceroute &&
sudo apt-get install -y python-gobject-dev liborc-0.4-dev gir1.2-gst-* &&
sudo apt-get install -y texstudio texlive-latex-extra texlive-generic-extra texlive-full &&
sudo apt-get install -y liblz4-tool liblz-dev libbz2-dev &&
sudo apt-get install -y kexec-tools &&
sudo apt-get install -y openjdk-8-jre-headless &&
sudo apt-get install -y hexchat tree &&
sudo apt-get install -y hardinfo lmbench &&
sudo apt-get install -y build-essential libtool autopoint autoconf bison gtk-doc-tools cmake &&
sudo apt-get install -y g++ &&
#BPF compiler
sudo apt-get install -y clang libc6-dev-i386 llvm libelf-dev &&
#dependency
sudo apt-get install -y libgcrypt20-dev &&
#Linaro tool-chain
sudo apt-get install -y gcc-arm-linux-gnueabi qemu-system &&
sudo apt-get install -y qemu qemu-system &&
#Bootloader
sudo apt-get install -y redboot-tools u-boot-tools lzop bc &&
sudo apt-get install -y xinetd tftpd tftp &&
#Needed for checking capability
sudo apt-get install -y libcap-dev &&
#Needed for menuconfig
sudo apt-get install -y ncurses-dev &&
#Needed for LEDE
sudo apt-get install -y libncurses5-dev gawk gettext unzip file libssl-dev wget binutils subversion libz-dev ccache xsltproc &&
#Firmware reverse engineering
sudo apt-get install -y binwalk squashfs-tools python-magic &&
sudo apt-get install -y gnuplot &&
sudo apt-get install -y v4l-utils &&
sudo apt-get install -y libva-dev vainfo mesa-utils mesa-common-dev inxi &&
sudo apt-get install -y libx264-dev &&
#Needed for GStreamer
sudo apt-get install -y flex yasm &&
#intsall latest NVIDIA driver (needed for good display)
sudo add-apt-repository ppa:graphics-drivers/ppa &&
sudo apt-get update -y &&
sudo apt-get install -y nvidia-361 nvidia-prime &&
#Needed for NVIDIA graphics driver, lsscsi, lstopo(shows cpu and PCIe topology), DPDK command
sudo apt-get install -y lsscsi cpuset sysstat rt-tests libnuma-dev hwloc &&
sudo apt-get install -y libvirt-bin libvirt-dev &&
#DVD burner
sudo apt-get install -y k3b &&
cd Downloads &&
wget https://gstreamer.freedesktop.org/src/gstreamer/gstreamer-1.10.4.tar.xz &&
wget https://gstreamer.freedesktop.org/src/gst-plugins-base/gst-plugins-base-1.10.4.tar.xz &&
wget https://gstreamer.freedesktop.org/src/gst-plugins-good/gst-plugins-good-1.10.4.tar.xz &&
wget https://gstreamer.freedesktop.org/src/gst-plugins-bad/gst-plugins-bad-1.10.4.tar.xz &&
wget https://gstreamer.freedesktop.org/src/gst-plugins-ugly/gst-plugins-ugly-1.10.4.tar.xz &&
wget https://gstreamer.freedesktop.org/src/gst-libav/gst-libav-1.10.4.tar.xz &&
wget https://gstreamer.freedesktop.org/src/gst-python/gst-python-1.10.4.tar.xz &&
files=( 
	"gstreamer-1.10.4.tar.xz" 
	"gst-plugins-base-1.10.4.tar.xz" 
	"gst-plugins-good-1.10.4.tar.xz" 
	)
for i in "${files[@]}"
do
  tar xvfJ $i && cd ${i%.tar.xz} && sudo ./autogen.sh && sudo ./configure && sudo make -j8 && sudo make install && sudo ldconfig && cd ..
done
files=( 
	"gst-plugins-bad-1.10.4.tar.xz" 
	"gst-plugins-ugly-1.10.4.tar.xz" 
	"gst-libav-1.10.4.tar.xz" 
	)
for i in "${files[@]}"
do
  tar xvfJ $i && cd ${i%.tar.xz} && sudo ./autogen.sh && sudo ./configure && sudo make -j8 && sudo make install && sudo ldconfig && cd ..
done
tar xvfJ gst-python-1.10.4.tar.xz && cd gst-python-1.10.4 && sudo ./configure && sudo make && sudo make install && sudo ldconfig && cd .. &&
cd .. &&
#sudo apt-get install -y gstreamer1.0-* &&
#GStreamer header packages
#sudo apt-get install -y libgstreamer1.0-* libgstreamer-plugins-base1.0-* libgstreamer-plugins-good1.0-* libgstreamer-plugins-bad1.0-* &&
sudo apt-get install -y python3-pip &&
sudo apt-get install -y python-pip &&
sudo apt-get install -y ninja-build &&
pip3 install meson &&
sudo apt-get install -y libfreenect-dev &&
sudo apt-get install -y libudev-dev libusb-1.0-0-dev libturbojpeg libjpeg-turbo8-dev libglfw3-dev beignet-dev libjpeg-dev libxrandr-dev doxygen libxi-dev libopencv-dev &&
sudo apt-get install -y libopenni2-dev &&
sudo apt-get install -y libogre-1.9-dev libois-dev libtinyxml-dev libhidapi-dev libsdl2-dev libglew-dev  freeglut3 freeglut3-dev libvisual-0.4-dev &&
sudo apt-get install -y libnice-dev &&
sudo apt-get install -y flex yasm &&
sudo apt-get install -y libmnl-dev &&
sudo apt-get install -y libgmp-dev &&
sudo apt-get install -y libreadline-dev &&
git config --global user.name "tamimcse" &&
git config --global user.email "tamim@csebuet.org" &&
git config --global credential.helper cache &&
git config --global credential.helper 'cache --timeout=3600' &&
git config --global core.fileMode false &&
cd /home/tamim &&
#git clone https://github.com/tamimcse/ns-3-dev-git.git &&
git clone https://github.com/tamimcse/Linux.git &&
git clone https://github.com/tamimcse/dpdk &&
git clone https://github.com/tamimcse/gst-streamer.git &&
#git clone https://github.com/tamimcse/libfreenect2.git &&
#git clone https://github.com/tamimcse/OpenHMD.git &&
git clone https://github.com/rampageX/firmware-mod-kit &&
git clone https://github.com/wkennington/linux-firmware &&
git clone git://github.com/mininet/mininet &&
git clone https://git.kernel.org/pub/scm/linux/kernel/git/shemminger/iproute2.git &&
#git clone https://git.lede-project.org/source.git lede &&
#cd lede && ./scripts/feeds update -a && ./scripts/feeds install -a && git config core.fileMode && cd .. &&
git config --global core.compression 0 &&
git clone --depth 1 https://_tamim_@bitbucket.org/_tamim_/research.git &&
cd research &&
git fetch --unshallow &&
cd .. &&
git clone https://_tamim_@bitbucket.org/_tamim_/website.git && 
sudo chmod a+rwx -R * &&
cd Linux && git config core.fileMode false && cd .. &&
cd dpdk && git config core.fileMode false && cd .. &&
#cd ns-3-dev-git && git config core.fileMode false && cd .. &&
cd research && git config core.fileMode false && cd .. &&
cd website && git config core.fileMode false && cd .. &&
cd gst-streamer && git config core.fileMode false && cd .. &&
cd iproute2 && git config core.fileMode false &&  sudo ./configure && make -j8 && sudo make install && cd .. &&
cd Linux &&
make defconfig &&
cd .. &&
#cd ns-3-dev-git &&
#sudo ./waf configure --enable-examples &&
#cd .. &&
cd mininet/util/ &&
sudo ./install.sh -fnv &&
cd ../../ &&
#cd OpenHMD && sudo ./autogen.sh && sudo ./configure && sudo make -j8 && sudo make install && cd .. &&
#cd libfreenect2 && sudo mkdir build && cd build && sudo cmake .. && sudo make && sudo make install && cd .. &&
cd Downloads &&
wget http://download.netbeans.org/netbeans/8.2/final/bundles/netbeans-8.2-cpp-linux-x64.sh &&
sudo chmod a+rwx netbeans-8.2-cpp-linux-x64.sh &&
sudo sh netbeans-8.2-cpp-linux-x64.sh &&
cd .. &&
cd Downloads &&
wget http://www.syntevo.com/static/smart/download/smartgit/smartgit-17_1_3.deb &&     
sudo chmod a+rwx smartgit-17_1_3.deb &&
sudo dpkg -i smartgit-17_1_3.deb &&
sudo apt-get -f install &&
cd .. &&
sudo rm -R openflow &&
#Increase heap size of Netbeans manually. Otherwise netbeans often cause trouble parsing kernel code.
#To do so, open up /usr/local/netbeans-version/etc/netbeans.conf. Change -J-Xms. That is, update 
#
#netbeans_default_options="-J-client -J-Xss2m -J-Xms32m -J-Dapple.laf.useScreenMenuBar=true -J-Dapple.awt.graphics.UseQuartz=true -J-Dsun.java2d.noddraw=true -J-#Dsun.java2d.dpiaware=true -J-Dsun.zip.disableMemoryMapping=true"
#to
#netbeans_default_options="-J-client -J-Xss2m -J-Xms1024m -J-Dapple.laf.useScreenMenuBar=true -J-Dapple.awt.graphics.UseQuartz=true -J-Dsun.java2d.noddraw=true -J-#Dsun.java2d.dpiaware=true -J-Dsun.zip.disableMemoryMapping=true"
