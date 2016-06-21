#! /bin/bash

FG='#cccccc'
BG='#2d2d2d'

fn1="Inconsolata:size=11"
fnT="Inconsolata:bold:size=11"
color1="#f99157"
color2="#99cc99"
(
echo "
    ^fn($fn1)^fg($color2)What would you like to do?^fg()
    ^fg($color1)^ca(1, shutdown now)Shut Down^ca()               ^ca(1, systemctl suspend)Suspend^ca() ^fn()^fg()
"
) | dzen2 -p -x 1105 -y 700 -w 350 -h 40 -bg $BG -fg $FG -l 3 -sa l -ta c -e 'onstart=uncollapse;button1=exit;button3=exit' -fn $fn1
