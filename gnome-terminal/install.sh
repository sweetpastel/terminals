#!/usr/bin/env bash

log_info="$(date +"%H:%M:%S") \e[0;34mINFO\e[0m"
log_error="$(date +"%H:%M:%S") \e[1;31mERROR\e[0m"
log_warning="$(date +"%H:%M:%S") \e[0;33mWARNING\e[0m"
log_success="$(date +"%H:%M:%S") \e[0;32mSUCCESS\e[0m"

profile="$1"
dconf_dir="/org/gnome/terminal/legacy/profiles:"

alert () {
  todo=$1
  str=$2
  
  case "$todo" in
    -e | --error)
      printf "$log_error %s\n" "$str"
    ;;
    -w | --warning)
      printf "$log_warning %s\n" "$str"
    ;;
    -s | --success)
      printf "$log_success %s\n" "$str"
    ;;
    *)
      printf "$log_info %s\n" "$1"
    ;;
  esac
}

create_default_profile () {
    profile_id=$(uuidgen)

    dconf write $dconf_dir/default "'$profile_id'"
    dconf write $dconf_dir/list "['$profile_id']"
    dconf write $dconf_dir/:$profile_id/visible-name "'Default'"
}

get_uuid () {
    name=$1

    for uuid in $(dconf list "$dconf_dir/"); do
      [ "$(dconf read "$dconf_dir/$uuid"visible-name)" = "'$name'" ] && echo $uuid
    done

    echo
}

alert "Checking profiles..."

uuid=$(get_uuid "$profile")

if [ -z "$uuid" ] && [ -z "$(dconf list "$dconfdir/")" ]; then
    alert -w "No profile was found. Creating 'Default' profile..."
    create_default_profile
    profile="Default"
    uuid="$(get_uuid "$profile")"
elif [ -z "$uuid" ]; then
    alert -e "Profile '${profile}' does not exist"
    alert "Use one of the following profiles or create a new one:"
    for prf in $(dconf list "$dconfdir/"); do
        dconf read "$dconfdir/$prf"visible-name
    done
    exit 1
fi

alert -s "Profile found!"
alert "Are you sure you want to overwrite the selected profile ($profile)? (Type YES to continue)"

read confirmation
if [ "$(echo $confirmation | tr '[:lower:]' '[:upper:]')" != YES ]; then
    echo "Confirmation failed - ABORTING!"
    exit 1
fi

echo 
alert -w "Proceeding..."
alert -w "Applying settings..."

profile_path="$dconf_dir/$uuid"

dconf write "$profile_path"use-theme-colors "false"
dconf write "$profile_path"foreground-color "'#ffdede'"
dconf write "$profile_path"background-color "'#1b1f23'"
dconf write "$profile_path"bold-color-same-as-fg "true"
dconf write "$profile_path"cursor-colors-set "true"
dconf write "$profile_path"cursor-foreground-color "'#1b1f23'"
dconf write "$profile_path"cursor-background-color "'#ffdede'"
dconf write "$profile_path"highlight-colors-set "false"

alert -w "Applying color palette..."

dconf write "$profile_path"palette "['#161a1e', '#e5a3a1', '#b4e3ad', '#ece3b1', '#a3cbe7', '#ceace8', '#c9d4ff', '#343a40', '#43474b', '#f9b7b5', '#c8f7c1', '#fff7c5', '#b7dffb', '#e2c0fc', '#dde8ff', '#f8f9fa']"

echo

alert -s "You are all set! Now, restart your terminal :)"