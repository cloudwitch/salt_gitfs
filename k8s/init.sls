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
    require:
      - k8s repo