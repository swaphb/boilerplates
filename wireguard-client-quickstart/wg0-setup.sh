## Export config variables:
export ALLOCATED_IP=
export DNS_ADDRESS=
export REMOTE_PUB_KEY=
export ALLOWED_IPS=
export ENDPOINT=
export KEEP_ALIVE_TIME=

## Install the Client, Generate keys, Move them to proper folder:
sudo apt-get -y install wireguard
umask 077
wg genkey > wg0.key
wg pubkey < wg0.key > wg0.pub
sudo mv wg0.key wg0.pub /etc/wireguard

## Install resolveconf:  
sudo apt-get install -y resolvconf

## Create the config file:  
sudo echo "[Interface] 
PostUp = wg set %i private-key /etc/wireguard/wg0.key 
Address = $ALLOCATED_IP
DNS = $DNS_ADDRESS 
[Peer] 
PublicKey = $REMOTE_PUB_KEY 
AllowedIPs = $ALLOWED_IPS
Endpoint = $ENDPOINT 
PersistentKeepalive = $KEEP_ALIVE_TIME" > /etc/wireguard/wg0.conf

## Then cat out add your **public** key to the remote gateway:
sudo cat /etc/wireguard/wg0.pub

echo ***Send this Public Key to your gateway administrator***