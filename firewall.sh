#!/bin/bash

# Apagando todas as regras
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X

# Mudando a politica - Come�a bloqueando tudo
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

# Libera conex�es pre-estabelecidas
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT

# Liberar HTTPS - aqui voc� coloca o IP do dom�nio
iptables -A OUTPUT -p tcp -d xx.xx.xx.xx --dport 443 -m state --state NEW -j ACCEPT

# Liberar HTTP - aqui voc� coloca o IP do dom�nio
iptables -A OUTPUT -p tcp -d xx.xx.xx.xx --dport 80 -m state --state NEW -j ACCEPT

# Liberar DNS
iptables -A OUTPUT -p tcp --dport 53 -m state --state NEW -j ACCEPT
iptables -A OUTPUT -p udp --dport 53 -m state --state NEW -j ACCEPT

#Liberar DHCP - na minha rede interna usa DHCP
iptables -A OUTPUT -p tcp --dport 67 -m state --state NEW -j ACCEPT
iptables -A OUTPUT -p udp --dport 67 -m state --state NEW -j ACCEPT