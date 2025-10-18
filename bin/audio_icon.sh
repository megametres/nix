# Define your two sink names here
SPEAKER="alsa_output.pci-0000_e5_00.1.hdmi-stereo-extra1"
HEADPHONE="alsa_output.pci-0000_e5_00.6.analog-stereo"

# Get the current default sink
CURRENT_SINK=$(pactl get-default-sink)

# Decide which sink to switch to
if [ "$CURRENT_SINK" = "$SPEAKER" ]; then
    echo "󰓃"
else
    echo " "
fi
