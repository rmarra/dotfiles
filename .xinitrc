[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
setxkbmap -model abnt2 -layout br -variant abnt2
exec awesome
