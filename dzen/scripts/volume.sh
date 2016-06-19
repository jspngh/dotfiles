#/bin/bash


vol_state=$(amixer get Master | grep "Front Left:" | awk '{print $5}' | tr -d '[]' | tr -d '%')
mute=$(amixer get Master | grep "Front Left:" | awk '{print $6}' | tr -d '[]')

if [[ "$mute" = "off" ]]
	then
	icon="^fg(#222222)^fn(FontAwesome:size=13)^fn()"
elif  (("$vol_state" >= 8)) && (("$vol_state" <= 16))
	then
	icon="^fn(FontAwesome:size=13)^fn()"
elif (("$vol_state" > 16)) && (("$vol_state" <= 37))
	then
	icon="^fn(FontAwesome:size=13)^fn()"
else
	icon="^fn(FontAwesome:size=13)^fn()"
fi

echo "$icon"
