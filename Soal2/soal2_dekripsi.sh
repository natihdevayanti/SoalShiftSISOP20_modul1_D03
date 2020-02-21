#!/bin/bash
nama="$(echo $* | awk -F "." '{print $1}')"
if [[ -f $1 ]]; then
upper=({A..Z})
lower=({a..z})
hour=$(date +"%H")
hour1=$(($hour-1))
up1=${upper[hour]}
low1=${lower[hour]}
up2=${upper[hour1]}
low2=${lower[hour1]}
random="$(LC_CTYPE=C tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c28)" || true
decrypt="$(echo "$nama" | tr ["$up1"-ZA-"$up2"] [A-Z] | tr ["$low1"-za-"$low2" [a-z]])"
mv $1 "$decrypt".txt
echo "selamat! file anda telah di dekripsi"
else
echo "file tidak ditemukan"
fi
