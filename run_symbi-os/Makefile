docker_restart:
	sudo docker restart linux_builder35
docker_attach:
	sudo docker attach linux_builder35
docker_run:
	docker run --network host --privileged -idt --name linux_builder36 fedora:36
docker_run35:
	sudo docker run --network host --privileged -idt --name linux_builder35 fedora:35
docker_rm:
	docker rm linux_builder36


install_docker:
	sudo dnf install dnf-plugins-core -y
	sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo -y
	sudo dnf install docker-ce docker-ce-cli containerd.io -y

start_docker_service:
	sudo systemctl start docker
enable_docker_service:
	systemctl enable docker

start_docker_service_on_boot:
	sudo systemctl enable docker

run_hw:
	sudo docker run hello-world

run_tu_fed36:
	sudo docker run -d --name tu_fed36 -it fedora:36

attach_tu_fed36:
	sudo docker attach tu_fed36

pull:
	docker pull ghcr.io/tommy-u/sym:latest

tag:
	docker tag 57 ghcr.io/tommy-u/sym:latest	

push:
	docker push  ghcr.io/tommy-u/sym:latest

bridge:
	docker network create --driver=bridge  --subnet=192.168.19.0/24  --ip-range=192.168.19.2/24  --gateway=192.168.19.1  br0

install_git_make:
	dnf install git make  -y

group_install:
	dnf group install "C Development Tools and Libraries" "Development Tools" -y
	dnf install fedpkg fedora-packager rpmdevtools ncurses-devel pesign grubby openssl-devel bc openssl htop the_silver_searcher redis psmisc libvirt @virtualization -y



# Setup new cont #############
# mkdir ~/local_disk
# mount /dev/sda1 local_disk/
# pull run repo
# dnf install make git
# make install_prereqs
# Install programs
# add to bashrc
# cp -r linux_ro/ linux
# switch onto right branch
# git checkout 5.14-config
# pick a good config
# make olddefconfig
# accept KSCAN default option (we think is b/c new compiler option)
# make -j32

