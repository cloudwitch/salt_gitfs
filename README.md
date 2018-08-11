Pheonix991's Salt GitFS.

These are public salt states that I use for my homelab.

Install salt minion, setup the minon_id and 
```
curl -L https://bootstrap.saltstack.com -o install_salt.sh &&\
sudo sh install_salt.sh -P -i $HOSTNAME -x python3
```