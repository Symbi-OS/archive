# This is supposed to help in setting up a network for vms.
# It can create a bridge and tap(s). It makes the bridge function as
# the master of the tap(s). It adds an address for the bridge and
# brings it up.

.PHONY: clean make_tap make_br rm_tap rm_br addr_add_tap set_tap_master_br clean create_interfaces all ping_br

TAP_LAB=tap_alpha
TAP2_LAB=tap_beta
BR_LAB=vm_br
IP_ADDR=192.168.42.0
IP_ADDR_FULL=$(IP_ADDR)/24

IP_SERVER=192.168.19.55
IP_CLIENT=192.168.19.66

IP_SERVER_FULL=$(IP_SERVER)/24
IP_CLIENT_FULL=$(IP_CLIENT)/24

SERVER_DEV=enp44s0u2
CLIENT_DEV=en6

all: set_tap_master_br addr_add_br
	sudo ip link set up $(BR_LAB)
	sudo ip link set up $(TAP_LAB)

extra_tap: all
	sudo ip tuntap add dev $(TAP2_LAB) mode tap multi_queue
	sudo ip link set $(TAP2_LAB) master $(BR_LAB)
	sudo ip link set up $(TAP2_LAB)

ping_br:
	ping $(IP_ADDR)

set_tap_master_br: create_tap create_br
	sudo ip link set $(TAP_LAB) master $(BR_LAB)

create_tap:
	sudo ip tuntap add dev $(TAP_LAB) mode tap multi_queue

addr_add_br: create_br
	sudo ip addr add $(IP_ADDR_FULL) dev $(BR_LAB)

create_br:
	sudo ip link add name $(BR_LAB) type bridge

rm_tap:
	sudo ip link set $(TAP_LAB) down
	sudo ip link delete $(TAP_LAB)
	- sudo ip link delete $(TAP2_LAB)

# REDIS BAREMETAL TARGETS 

rm_br:
	sudo ip link set $(BR_LAB) down
	sudo ip link delete $(BR_LAB)

ip_server:
	ip a
	sudo ip link set $(SERVER_DEV) down
	sudo ip addr flush $(SERVER_DEV)
	sudo ip addr add $(IP_SERVER_FULL) dev $(SERVER_DEV)
	sudo ip link set $(SERVER_DEV) up
	ip a

ip_client:
	ip a
	sudo ip link set $(CLIENT_DEV) down
	# sudo ip addr flush $(CLIENT_DEV)
	sudo ip addr add $(IP_CLIENT_FULL) dev $(CLIENT_DEV)
	sudo ip link set $(CLIENT_DEV) up
	ip a

ping_s2c:
	ping $(IP_CLIENT)

ping_c2s:
	ping $(IP_SERVER)

firewall_status:
	systemctl status firewalld.service
	ps aux | grep firewall

firewall_disable:
	make firewall_status
	sudo systemctl stop firewalld.service
	sudo systemctl disable firewalld	
	sudo systemctl mask --now firewalld
	make firewall_status

nmap_s2c:
	nmap $(IP_CLIENT) #specific ports: -p22 -p80 -p6379
			  # -sT for TCP conect scan
			  # --traceroute to trace route

nmap_c2s:
	nmap $(IP_SERVER)

telnet_s2c:
	telnet $(IP_CLIENT) # to specify port <host> <port>

telnet_c2s:
	telnet $(IP_SERVER)

trace_s2c:
	traceroute $(IP_CLIENT)
	traceroute $(IP_CLIENT) -i $(SERVER_DEV)

trace_c2s:
	traceroute $(IP_SERVER)
	traceroute $(IP_SERVER) -i $(CLIENT_DEV)

check_routes:
	sudo iptables -L INPUT
	ip route show

clean: rm_tap rm_br

#  make ip_server SERVER_DEV=eno2 -n
