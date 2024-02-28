sudo ./disable_boost.py
sudo ./disable_ht.sh
sudo ./disable_cstates.sh
sudo cpupower set -b 0
sudo cpupower frequency-set -g performance
