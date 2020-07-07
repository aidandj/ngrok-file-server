python -m http.server -d files &> /dev/null &
SERVERPID=$!

ngrok http 8000 > /dev/null &
NGROKPID=$!

sleep 1

PUBIP=$(curl -s localhost:4040/api/tunnels | jq -r '.tunnels[0].public_url')

echo $PUBIP | pbcopy

echo "Serving on $PUBIP"
echo "Server IP copied to clipboard"
read -p "Press enter to stop"

kill -s 9 $NGROKPID
kill -s 9 $SERVERPID
