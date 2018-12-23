#!/bin/bash
RED='\033[0;31m'
NC='\033[0m' # No Color
BLUE='\033[0;34m'
GREEN='\033[0;32m'

ask_before_execute() {
	echo -e $var1
	echo -e -n "${RED}Continue ? (y/n)? ${NC}"
	old_stty_cfg=$(stty -g)
	stty raw -echo ; answer=$(head -c 1) ; stty $old_stty_cfg # Careful playing with stty
	if echo "$answer" | grep -iq "^y" ;then
		$var2
	else
		exit
	fi
}

echo -e "${GREEN}Go to the root of download folder as specified, if not please exit before the script harms you. "
echo -n -e "Continue ? (y/n)? ${NC}"
old_stty_cfg=$(stty -g)
stty raw -echo ; answer=$(head -c 1) ; stty $old_stty_cfg # Careful playing with stty
if echo "$answer" | grep -iq "^y" ;then
	echo -e "${BLUE}Starting ffmpeg installation...${NC}"
else
	exit
fi

var1="${RED}Install YASM, NASM, Video4Linux-Dev, Lib2dl2-dev.${NC}"
var2="sudo apt-get install nasm yasm libv4l-dev libsdl2-dev"
ask_before_execute

cd x264
./configure --disable-asm --enable-debug --enable-pic --enable-shared --disable-mp4-output

var1="${RED}make x264 ?${NC}"
var2="make" 
ask_before_execute

sudo make install

cd ../ffmpeg-3.3.5
./configure --enable-gpl --enable-libx264 --enable-swscale --enable-debug --enable-ffplay --disable-optimizations --disable-stripping

var1="${RED}make ffmpegg ?${NC}"
var2="make"
ask_before_execute

sudo make install

sudo ldconfig
echo -e "${BLUE}FFMPEG cross compiled with X264.${NC}"
