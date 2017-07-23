#!/bin/bash
# Duckie's heaps mad W1-enabled Headphone Power Script.  Version 1.3
# Contributors: ankushg, spetykowski, danozdotnet
# Check http://blog.duklabs.com/airpods-power-in-touchbar/ for more info.



# Put the Mac Address of your W1-enabled headphones (Apple AirPods, Beats Solo3, Powerbeats3, BeatsX) in here.
MACADDR='7c-04-d0-af-88-62'

# See if we're connected to them
CONNECTED=$(system_profiler SPBluetoothDataType | awk "/$MACADDR/i {for(i=1; i<=6; i++) {getline; print}}" | grep "Connected: Yes" | sed 's/.*Connected: Yes/1/')
if [ "$CONNECTED" ]; then
	BTDATA=$(defaults read /Library/Preferences/com.apple.Bluetooth | awk "/\"$MACADDR\".=\\s*\\{[^\\}]*\\}/i {for(i=1; i<=6; i++) {getline; print}}")
	
    COMBINEDBATT=$(echo "$BTDATA" | grep BatteryPercentCombined | sed 's/.*BatteryPercentCombined = //' | sed 's/;//') 
	HEADSETBATT=$(echo "$BTDATA" | grep HeadsetBattery | sed 's/.*HeadsetBattery = //' | sed 's/;//') 
	SINGLEBATT=$(echo "$BTDATA" | grep BatteryPercentSingle | sed 's/.*BatteryPercentSingle = //' | sed 's/;//') 
    CASEBATT=$(echo "$BTDATA" | grep BatteryPercentCase | sed 's/.*BatteryPercentCase = //' | sed 's/;//') 
	LEFTBATT=$(echo "$BTDATA" | grep BatteryPercentLeft | sed 's/.*BatteryPercentLeft = //' | sed 's/;//') 
	RIGHTBATT=$(echo "$BTDATA" | grep BatteryPercentRight | sed 's/.*BatteryPercentRight = //' | sed 's/;//') 

	OUTPUT="🎧"
	[[ !  -z  $COMBINEDBATT  ]] && OUTPUT="$OUTPUT $COMBINEDBATT%"
	[[ !  -z  $HEADSETBATT  ]] && OUTPUT="$OUTPUT $HEADSETBATT%"
	[[ !  -z  $SINGLEBATT  ]] && OUTPUT="$OUTPUT $SINGLEBATT%"
	[[ !  -z  $LEFTBATT  ]] && OUTPUT="$OUTPUT L: $LEFTBATT%"
	[[ !  -z  $RIGHTBATT  ]] && OUTPUT="$OUTPUT R: $RIGHTBATT%"
	[[ !  -z  $CASEBATT  ]] && OUTPUT="$OUTPUT C: $CASEBATT%"
	
	echo "$OUTPUT"
else
	echo "🎧 Not Connected"
fi

