
sudo ip link set down enp0s31f6
sleep 1
sudo ip addr flush enp0s31f6
sleep 1
sudo ip addr add dev enp0s31f6 192.168.122.69/19
sleep 1
sudo ip link set up enp0s31f6
