[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
setxkbmap -layout us -variant intl
xset s off -dpms
exec awesome
