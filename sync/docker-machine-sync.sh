#!/usr/bin/env bash

set -e;

# CONFIGURATION
DOCKER_MACHINE_ID=${DOCKER_MACHINE_ID:-`docker-machine active`}
SHARED_DIR=${SHARED_DIR:-/Users}
UNISON_CONFIG_DIR=$(pwd)/${UNISON_CONFIG_DIR:-.docker-machine-sync}

loadConfigFromFile() { eval $(sed -e 's/:[^:\/\/]/="/g;s/$/"/g;s/ *=/=/g' docker-machine-sync.conf); }
loadConfigFromFile

echo "Docker machine: $DOCKER_MACHINE_ID"
echo "Docker machine shared dir: $SHARED_DIR"
echo "Unison config dir: $UNISON_CONFIG_DIR"
# CONFIGURATION: END


# LOGIC
dockerMachineSSH() { docker-machine ssh $DOCKER_MACHINE_ID $1; }

unmountSharedDirectory () {
    printf "Unmount $SHARED_DIR inside docker-machine: "
    if [[ $(dockerMachineSSH 'cat /proc/mounts' | grep " $SHARED_DIR ") ]]; then
        dockerMachineSSH "sudo umount $SHARED_DIR"
        echo "Done!"
    else
        echo "Doesnt exists!"
    fi
    dockerMachineSSH "sudo mkdir -p $SHARED_DIR; sudo chown docker $SHARED_DIR;"
}

installUnison () {
    printf "Install unison inside docker-machine "
    dockerMachineSSH "cd / && sudo curl -sL https://www.archlinux.org/packages/extra/x86_64/unison/download | sudo tar Jx"
    echo "Done!"
}

configureUnison() {

    printf "Setup unison inside docker-machine "

    mkdir -p $UNISON_CONFIG_DIR
    echo "
Host $(docker-machine ip ${DOCKER_MACHINE_ID})
User docker
IdentityFile ~/.docker/machine/machines/${DOCKER_MACHINE_ID}/id_rsa
" > ${UNISON_CONFIG_DIR}/.ssh_config
    echo "
root = ${SHARED_DIR}
root = ssh://$(docker-machine ip ${DOCKER_MACHINE_ID})${SHARED_DIR}
sshargs = -F ${UNISON_CONFIG_DIR}/.ssh_config
ignore = Name $IGNORE
prefer = ${SHARED_DIR}
follow = Regex .*
repeat = 2
terse = true
dontchmod = true
perms = 0
fastcheck = false
" > "$UNISON_CONFIG_DIR/profile.prf"

    echo "Done!"
}


unmountSharedDirectory
installUnison
configureUnison
# LOGIC: END




# TESTING STUFF

# recreate mount inside docker-machine to test removing again and again
# sudo mount -t nfs -o rw,relatime,vers=3,rsize=65536,wsize=65536,namlen=255,hard,proto=tcp,port=2049,timeo=70,retrans=3,addr=192.168.99.1  192.168.99.1:/Users /Users