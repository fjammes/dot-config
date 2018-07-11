set -e
set -x

# Install configure.sh dependencies
yum install -y cmake go python-devel zsh

# Install EPEL packages
yum install -y byobu htop

# Disable SELinux
setenforce 0
sed -i "s/SELINUX=enforcing/SELINUX=disabled/" /etc/sysconfig/selinux
sed -i 's|Environment="KUBELET_CGROUP_ARGS=|#Environment="KUBELET_CGROUP_ARGS=|' /etc/systemd/system/kubelet.service.d/10-kubeadm.conf

# Data and log are stored on Openstack host
mkdir -p /qserv/custom /qserv/data /qserv/log qserv/tmp /mnt/qserv
chown -R '1000:1000' /qserv
/bin/systemctl daemon-reload
/bin/systemctl restart  docker
/bin/systemctl restart  systemd-sysctl

# Install vim8
curl -L https://copr.fedorainfracloud.org/coprs/mcepl/vim8/repo/epel-7/mcepl-vim8-epel-7.repo -o /etc/yum.repos.d/mcepl-vim8-epel-7.repo
yum update -y vim-common vim-minimal && yum install -y vim
