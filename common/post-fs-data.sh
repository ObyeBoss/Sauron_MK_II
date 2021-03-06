#Force high performance DAC by ZeroInfinity@XDA
HPM=$(find $ROOT/sys/module -name high_perf_mode)
if [ $HPM ]; then
	chmod 666 $HPM
	echo "1" > $HPM
	chmod 444 $HPM
fi

#Force impedance detection by UltraM8@XDA
IDE=$(find $ROOT/sys/module -name impedance_detect_en)
if [ $IDE ]; then
	chmod 666 $IDE
	echo "1" > $IDE
	chmod 444 $IDE
fi

#Preallocate DMA memory buffer expander
MSS=$(find $ROOT/sys/module -name maximum_substreams)
if [ $MSS ]; then
	chmod 666 $MSS
	echo "8" > $MSS
	chmod 444 $MSS
fi

#Probably the double-volume for htc framework
BTS=$(find $ROOT/sys/devices/virtual/switch/beats/state)
if [ $BTS ]; then
	chmod 666 $BTS
	echo "1" > $BTS
	chmod 444 $BTS
fi

AX7=$(grep -E "ro.build.product=axon7|ro.build.product=ailsa_ii" $SYS/build.prop)
V20=$(grep "ro.product.device=elsa" $SYS/build.prop)
V30=$(grep "ro.product.device=joan" $SYS/build.prop)
G6=$(grep "ro.product.device=lucye" $SYS/build.prop)
Z9=$(grep "ro.product.model=NX508J" $SYS/build.prop)
Z9M=$(grep -E "ro.product.model=NX510J|ro.product.model=NX518J" $SYS/build.prop)
Z11=$(grep "ro.product.model=NX531J" $SYS/build.prop)
LX3=$(grep "ro.build.product=X3c50" $SYS/build.prop)

# Mixer edits by UltraM8
if [ "$AX7" ]; then
 tinymix 'AKM HIFI Switch Sel' 'ak4490'
 tinymix 'Smart PA Init Switch' 'On'
 tinymix 'ADC1 Digital Filter' 'sharp_roll_off_88'
 tinymix 'ADC2 Digital Filter' 'sharp_roll_off_88'
fi
## AX7 pathces by Skrem339
if [ "$LX3" ]; then
 tinymix 'Es9018 CLK Divider' 'DIV4'
 tinymix 'ESS_HEADPHONE Off' 'On'
fi
if [ "$X9" ]; then
 tinymix 'Es9018 CLK Divider' 'DIV4'
 tinymix 'Es9018 Hifi Switch' 1
fi   
if [ "$Z9" ] && [ "$Z9M" ]; then
 tinymix 'HP Out Volume' 22 
 tinymix 'ADC1 Digital Filter' 'sharp_roll_off_88'
 tinymix '"ADC2 Digital Filter' 'sharp_roll_off_88'
fi
if [ "$Z11" ]; then
 tinymix 'AK4376 DAC Digital Filter Mode' 'Slow Roll-Off'
 tinymix 'AK4376 HPL Power-down Resistor' 'Hi-Z'
 tinymix 'AK4376 HPR Power-down Resistor' 'Hi-Z'
 tinymix 'AK4376 HP-Amp Analog Volume' 15
fi
if [ "$V20" ] && [ "$V30" ] && [ "$G6" ]; then
 tinymix 'Es9018 AVC Volume' 14
 tinymix 'Es9018 HEADSET TYPE' 1
 tinymix 'Es9018 State' 'Hifi'
 tinymix 'HIFI Custom Filter' 6
fi 
#