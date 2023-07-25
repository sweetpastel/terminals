# tty/console
tty themed with **sweetpastel**

## install

1. run the script below in your terminal

```sh
curl -fsSL "https://raw.githubusercontent.com/sweetpastel/terminals/main/tty/tty.sh" | sh
```

2. copy the text it outputs and set it in your kernel options
3. Restart your computer

## setup kernel options

### grub

1. edit `/etc/default/grub` and append to the `GRUB_CMDLINE_LINUX` string
2. run `sudo update-grub`
    - if your system doesn't have that, instead run `sudo grub-mkconfig -o /boot/grub/grub.cfg`

### systemd-boot

1. edit the boot entry located in `/boot/loader/entries/`
2. append to the `options` line
3. run `sudo bootctl update`

### limine

1. edit `/boot/limine.cfg`
2. append to the boot entry's `CMDLINE` line

### other

for other bootloaders or for more information, [see here on ArchWiki](https://wiki.archlinux.org/title/Kernel_parameters)

## acknowledgements

- thanks to [catppuccin](https://github.com/catppuccin) [``Echo``](https://github.com/CallMeEchoCodes) and [``merkb``](https://github.com/mekb-turtle) for the cappuccin tty install script and the readme