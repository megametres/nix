# Define your two sink names here
SINK1="alsa_output.pci-0000_e5_00.1.hdmi-stereo-extra1"
SINK2="alsa_output.pci-0000_e5_00.6.analog-stereo"

# Get the current default sink
CURRENT_SINK=$(pactl get-default-sink)

# Decide which sink to switch to
if [ "$CURRENT_SINK" = "$SINK1" ]; then
    NEW_SINK="$SINK2"
else
    NEW_SINK="$SINK1"
fi

# Set the new default sink
pactl set-default-sink "$NEW_SINK"

# Move all current sink inputs to the new sink
for INPUT in $(pactl list short sink-inputs | awk '{print $1}'); do
    pactl move-sink-input "$INPUT" "$NEW_SINK"
done

# Update waybar
pkill -SIGRTMIN+10 waybar
