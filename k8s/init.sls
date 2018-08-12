k8s repo:
  pkgrepo.managed:
    - humanname: Kubernetes
    - url_key: https://packages.cloud.google.com/apt/doc/apt-key.gpg
    - name: deb http://apt.kubernetes.io/ kubernetes-xenial main
    - file: /etc/apt/sources.list.d/kubernetes.list

k8s packages:
  pkg.installed:
    pkgs:
      - kubeadm
      - curl
    require:
      - pkgrepo: k8s repo



<add jinja for master grain>
kinit:
  cmd.run:
    name: kubeadm init --pod-network-cidr 10.244.0.0/16
</add jinja for master grain


install flannel:
  cmd.run:
    name: curl -sSL https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml | sed "s/amd64/arm/g" | kubectl create -f -
    require:
    - cmd: kinit

<add jinja for worker nodes>
Generate token on k8s master, `kubeadm token create --print-join-command`
Run command on the worker nodes
</add jinja for worker nodes>
