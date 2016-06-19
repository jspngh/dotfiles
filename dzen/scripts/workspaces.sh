#!/usr/bin/env zsh

function statusbar() {

	function tags() {
	des=$(wmctrl -d | awk '/*/ {print $10}')
	if [[ "$des" == "Main" ]]; then
    echo -e '^fg(#918B88)^fn(FontAwesome:size=13)^fn()^fg(#54746E) ^fn(FontAwesome:size=13)^fn() ^fn(FontAwesome:size=13)^fn() ^fn(FontAwesome:size=13)^fn() '
	elif [[ "$des" == "Programming" ]]; then
    echo -e '^fg(#54746E)^fn(FontAwesome:size=13)^fn() ^fg(#918B88)^fn(FontAwesome:size=13)^fn()^fg(#54746E) ^fn(FontAwesome:size=13)^fn() ^fn(FontAwesome:size=13)^fn() '
	elif [[ "$des" == "Misc" ]]; then
    echo -e '^fg(#54746E)^fn(FontAwesome:size=13)^fn() ^fn(FontAwesome:size=13)^fn() ^fg(#918B88)^fn(FontAwesome:size=13)^fn()^fg(#54746E) ^fn(FontAwesome:size=13)^fn() '
	elif [[ "$des" == "Spare" ]]; then
    echo -e '^fg(#54746E)^fn(FontAwesome:size=13)^fn() ^fn(FontAwesome:size=13)^fn() ^fn(FontAwesome:size=13)^fn() ^fg(#918B88)^fn(FontAwesome:size=13)^fn() '
	fi
	}
	echo "$(tags)"
}
	while true
	do
		echo "$(statusbar)"
		sleep 0.5
	done | dzen2 -bg '#191716' -fn '-*-gohufont-medium-r-*-*-11-*-*-*-*-*-*-*' -ta l -tw 167 -p
