if [[ $1 =~ ^[a-zA-Z]+$ ]]
then
rdm="$(LC_CTYPE=C tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c28)" || true
echo $rdm > /Users/putrinatih/$1.txt
else echo "error"
fi
