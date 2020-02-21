#!/bin/bash
nama=$(echo $* | awk -F "." '{print $1}')
if [[ $1 =~ ^[A-Za-z]+$".txt" ]]; then
upper=({A..Z})
lower=({a..z})
hour=$(date +"%H")
hour1=$(($hour-1))
up1=${upper[hour]}
low1=${lower[hour]}
up2=${upper[hour1]}
low2=${lower[hour1]}
rdm="$(LC_CTYPE=C tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c28)" || true
encrypt="$(echo "$nama" | tr [A-Z] ["$up1"-ZA-"$up2"] | tr [a-z] ["$low1"-za-"$low2"])"
echo $rdm > "$encrypt".txt
echo "selamat! file anda telah di enkripsi!"
else
echo "Harap menggunakan Alfabet"
fi


