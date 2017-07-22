#!/bin/bash
#-------------------------------------------------------------------------------------
#  -- Aubrey McIntosh, Ph.D.  $Id$
#  -- make iounote ls
#  --s
#-------------------------------------------------------------------------------------


#  patches to be back-ported to the installed environment
# -- none --


#  -- https://askubuntu.com/questions/393289/how-to-install-libdb4-8-dev-or-equivalent-on-13-10
#  -- this fails when the system is quarantined.
#  -- the following two files emulate the ppa addition.
cat <<EOF >> /etc/apt/sources.list.d/bitcoin-bitcoin-trusty.list
deb http://ppa.launchpad.net/bitcoin/bitcoin/ubuntu trusty main
# deb-src http://ppa.launchpad.net/bitcoin/bitcoin/ubuntu trusty main
EOF

#  -- apt-key --keyring /etc/apt/trusted.gpg.d/bitcoin-bitcoin.gpg exportall
cat <<EOF >> /tmp/pgp-temp
-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v1

mI0ETqh+ZAEEAKzPy5lAnW2sBYwSsK1tUl/Otnx7QQPBg3HOb4Mk9grKqo0pyD7D
219wuNAsQ3DCyQYm9mnDfOYZIfMEjitq3IQ6d2jtAuuu8EzriPORX9N5vv5dtnHb
uAdXQUFsm8Dnm6JREq8T8vY2M87HGCKLluTJ6AzrwTuP8Od+0MLhZP6xABEBAAG0
GUxhdW5jaHBhZCBQUEEgZm9yIEJpdGNvaW6IuAQTAQIAIgUCTqh+ZAIbAwYLCQgH
AwIGFQgCCQoLBBYCAwECHgECF4AACgkQ1G9FQohCzl6DtQP8DBKRlJeR7qxigqw4
TYRi5520g1a6PREK0In6l6SUYg8IM2NdyFwPUEA7ky8CYrMXvieiWol7c0bBVsYJ
lvZ7SlCPhG/sM7vHla+Gaz0mNb5wJyYmU3kVIYnJK4zVpVpKf0EC0FWSZ5YVvfOd
RFE9IAzuOni2nhfea1Lg6Js6S1KJAhwEEAECAAYFAlRr8b4ACgkQXLNh5VL7DRCf
3A//Sd6En0+j5ldrcrRb+erPlCeuwLzzyvci+vT/AJaRaKxEz2fydr7xhT5fNlam
8cM5wD0MWflM4zfDHT5tzC95XTQo0TfSxqk5ip+5DVRv1e/weKR/M3JLDew+NrT6
LEZtKwlCDRwu7gBfOhCqD3YnrWlkBM4RAFfOuM4aSOWFW2Z0HyRKjDHpMAsN9p/L
wqBN5VIxIp2hPoJOBLXmh5UJWfH4nPENSiXUIB1Ijcc/rs5yq+ftczE+C8cTy/nO
gUgvppWSPZZdpjAn0/oNs0XaZlTEH8dS/Lfq+HiTTcz5SfFwsjg/36i8/XPHSUsh
jF7daGu/vJRBSWFpcK942yiM4ndiTZCb6UHz9BxCqbx3NsGDv5zVECoL3FCY2lpA
/yKmXq7mV9e3ZG85W2E2beJhnkj/iH/XexCpxysM69Klb7FshY5b3pl/u5F8aNVA
Z4ACPH6h7dD5kYIpUs42CUsEOKEmv6AOfhD/ikMAvMMIJAwZ259KtKl+L1nJqRyT
/GFhOG1JhkIak99CwEJ7xgnrkiP/vLg20FJmY0RUzxObrPYv+Khgg7XSajbJe+Pi
PqQdcIeZnZjJPqQLJFlXxni7biSmuJn7UOG08b3exh8b/fV5RYrdP9jEW1+/+W8D
xbiiplt/r0UqnTnBndvzdZm0q5dHQP/IQXevVQeNxBkx3eKJAiIEEgECAAwFAlGq
vWcFgweGH4AACgkQ6/8lC4ueTn8IqQ//ZULH1+zMn/vy5CGQF3QWCdzz83F/pZwN
ISjelM39BF/VWNgGihZaPUtcYCukuJH2m1P6kkdQVBWlBamtElmvsZA2rKuBVWkf
Jo/l9naHC7x+SeZiLSx6NawHCUTAKkBEvVE1gSpwz0zCWtX4HovbOkTyyxO2DxUh
UD3na0x4X+RybukzeLOK+NBBE7Xxu3wyQMyEGoY3vyj/rlW6NauA9Btczy7dudy5
yROKVeR9IQKCMaOql+QZfVwOmX8gqReRnAiqBzK9c4KGNctcfKY/ifoUxDOsfFz8
c79avbYd92i+ZwuCpov6Yd48QTKbNaKqT/azfZ6anu6XIoX75kZNuSsf5xKN/0Ae
sMz6IWpobuH5aHBrphveQheGN3qDyZcPA1dh9Y4E1jCV2Z8COjYbk51+VPoHH4fl
ehNNnhdm/h3GycO0N48DdDxWC3f4P+m+jMjiKW2z1Z27PHNNQNwsvJwN7Qges6LB
rWBQ29BbRvPppnqK6v9ER86LSKgyWl8w+WQ5bXr7Cpnvq0o0An8WOI4eAnlbTqtG
1IlQBJkCpdHKxOF5X7k8JAXmkyKN1WksijaIDd2UKW/CkLf46nuGYHZf49R+N189
P/x98L0OvsgbmOgw2F4mPh6OWqbCAZEVtszGwjGuhlzY0l1qq4cDzMpWmF0oJ7fs
8gjDyLav+cQ=
=6FU8
-----END PGP PUBLIC KEY BLOCK-----
EOF
apt-key --keyring /etc/apt/trusted.gpg.d/bitcoin-bitcoin.gpg add /tmp/pgp-temp
apt-get update


#  -- a diagnostic -- reveals that libdb5.3 is installed
dpkg -l 'libdb*' | grep Berkeley


#  install packages used for both libdb4.8 build and libdb5.1 build
apt-get -y install \
 libdb4.8-dev libdb4.8++-dev \
 libboost-all-dev build-essential libssl-dev  \
 libboost-all-dev  qt4-qmake libqt4-dev  git-core ntp \
 libqrencode-dev libboost-all-dev  libminiupnpc-dev \
 software-properties-common



#  make IOUnote on top of new installed machine.



#  -- make and execute the client
cd ~passwd.username/opt/coins/iounote

chgrp -R iounote .
chmod -R g+w .

umask 0002
newgrp iounote
touch /mnt/this-should-be-root+iounote
qmake USE_QRCODE=1
make clean
touch check-the-owner-and-group-$EPOCH
make


#  -- https://github.com/bitcoin/bitcoin/blob/0.13/doc/build-windows.md
#  -- https://bitcointalk.org/index.php?topic=149479.0

apt-get -y install g++-mingw-w64-i686 mingw-w64-i686-dev g++-mingw-w64-x86-64 mingw-w64-x86-64-dev curl



