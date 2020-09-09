#!/bin/bash

# Instructions:
#   1. Boot Arch Linux flashdrive
#   2. Mount home partition on /mnt
#   3. Check TARGET_DISK variable
#   4. Run this script


# [!] will be erased
TARGET_DISK='/dev/sda'


BOOT_PARTITION=$TARGET_DISK'1'
ROOT_PARTITION=$TARGET_DISK'2'
HOME_PARTITION=$TARGET_DISK'3'
SWAP_PARTITION=$TARGET_DISK'4'
PACKAGES=$(cat packages.all | grep -v "#" | grep -v "^$")

HOSTNAME='paddle'


if [ $(whoami) != "root" ]; then
  echo 'Must be run as root'
  exit 1
fi


function line {
  echo "#####################################################################"
}

function confirm {
  echo
  echo '-----------------------------'
  echo ' PRESS ENTER TO CONTINUE'
  echo '-----------------------------'
  read
}


STEPS=9


if [ "$1" == "" ]; then

  echo
  line
  echo '# [1/'$STEPS'] Initial config'
  line

  loadkeys us-acentos
  timedatectl set-ntp true

  #cfdisk $TARGET_DISK
  umount /_setup > /dev/null 2>&1

  lsblk -f

  echo
  line
  echo '# [2/'$STEPS'] Formatting disk ('$BOOT_PARTITION')'
  line

  mkfs.vfat -F 32 $BOOT_PARTITION

  echo
  line
  echo '# [2/'$STEPS'] Formatting disk ('$ROOT_PARTITION')'
  line

  mkfs.ext4 $ROOT_PARTITION

  mkdir /_setup
  mount $ROOT_PARTITION /_setup

  mkswap $SWAP_PARTITION
  swapon $SWAP_PARTITION



  echo
  line
  echo '# [3/'$STEPS'] Mounting home and storage'
  line

  mkdir /_setup/boot
  mount $BOOT_PARTITION /_setup/boot

  mkdir /_setup/home
  mount $HOME_PARTITION /_setup/home

  mount



  echo
  line
  echo '# [4/'$STEPS'] Pacstrap'
  line

  echo
  echo 'The following packages will be installed:'
  echo $PACKAGES

  confirm

  time pacstrap /_setup $PACKAGES
  confirm

  genfstab -U /_setup >> /_setup/etc/fstab



  echo
  line
  echo '# [5/'$STEPS'] CH Rooting'
  line
  arch-chroot /_setup arch-install.sh chroot
fi


if [ "$1" == "chroot" ]; then


  # reflector
  #pacman -Syu --noconfirm
  #pacman -Syu --noconfirm reflector
  #reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist

  bootctl install
  BOOT_PARTUUID=$(blkid -s PARTUUID -o value $BOOT_PARTITION)

  cat > /boot/loader/entries/arch.conf << EOF
title   Arch Linux
linux   /vmlinuz-linux
initrd  /initramfs-linux.img
options root=PARTUUID=$BOOT_PARTUUID rw
EOF







  echo
  line
  echo '# [6/'$STEPS'] System configuration'
  line

  # fonts
  pacman -S --noconfirm noto-fonts ttf-dejavu ttf-roboto ttf-inconsolata


  line
  echo '# [7/'$STEPS'] Setting timezone'
  line


  # timezone, hostname
  ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
  hwclock --systohc
  echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
  locale-gen

  echo "LANG=en_US.UTF-8" > /etc/locale.conf
  echo "KEYMAP=us-acentos" > /etc/vconsole.conf
  echo $HOSTNAME > /etc/hostname
  echo "127.0.0.1		localhost" >> /etc/hosts
  echo "::1		    localhost" >> /etc/hosts
  echo "127.0.1.1		"$HOSTNAME".localdomain "$HOSTNAME >> /etc/hosts

  ls -la /etc/localtime


  echo
  line
  echo '# [8/'$STEPS'] Setting passwords'
  line


  # root password
  echo -e "\n>>> Please set ROOT password"
  echo -e '1234\n1234' | passwd
  echo '>>> Password set to `1234`. Change later.'


  # rmarra password
  echo -e "\n>>> Please set ema password"
  useradd -m rmarra
  echo -e '1234\n1234' | passwd rmarra
  echo '>>> Password set to `1234`. Change later.'


  # services
  systemctl enable dhcpcd
  systemctl enable docker


  # sudo
  usermod -aG wheel rmarra
  echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers

  echo '1234' | sudo -S -u rmarra true


  # docker
  usermod -aG docker rmarra



fi


# finish
line
echo "INSTALLATION DONE! REMOVE THE INSTALLATION MEDIA."
echo "Press ENTER to reboot"
line
read


reboot
