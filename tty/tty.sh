#!/usr/bin/env bash

red=229,163,161
green=180,227,173
yellow=236,227,177
blue=163,203,231
magenta=206,172,232
cyan=201,212,255

background=27,31,35
black=34,38,42
foreground=255,222,222
white=248,249,250
whitelighter=238,239,240

colors=("$background" "$red" "$green" "$yellow" "$blue" "$magenta" "$cyan" "$white" "$black" "$red" "$green" "$yellow" "$blue" "$magenta" "$cyan" "$whitelighter")

default_red=()
default_grn=()
default_blu=()

IFS=','

for i in "${colors[@]}"; do
    read -r r g b <<< "$i"

    default_red+=("$r")
    default_grn+=("$g")
    default_blu+=("$b")

done

echo "vt.default_red=${default_red[*]} vt.default_grn=${default_grn[*]} vt.default_blu=${default_blu[*]}"
unset IFS
