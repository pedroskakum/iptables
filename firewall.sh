#!/bin/bash

# Apagando todas as regras
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X

# Mudando a politica - Começa bloqueando tudo
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

# Libera conexões pre-estabelecidas
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT

# Liberar HTTPS - aqui você coloca o IP do domínio
iptables -A OUTPUT -p tcp -d xx.xx.xx.xx --dport 443 -m state --state NEW -j ACCEPT

# Liberar HTTP - aqui você coloca o IP do domínio
iptables -A OUTPUT -p tcp -d xx.xx.xx.xx --dport 80 -m state --state NEW -j ACCEPT

# Liberar DNS
iptables -A OUTPUT -p tcp --dport 53 -m state --state NEW -j ACCEPT
iptables -A OUTPUT -p udp --dport 53 -m state --state NEW -j ACCEPT

#Liberar DHCP - na minha rede interna usa DHCP
iptables -A OUTPUT -p tcp --dport 67 -m state --state NEW -j ACCEPT
iptables -A OUTPUT -p udp --dport 67 -m state --state NEW -j ACCEPT