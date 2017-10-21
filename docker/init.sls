#This state installs docker-ce.
#State will eventually have more OSs.
{% if grains['os'] == "Fedora" %}
dnf-plugins-core:
  pkg.installed:
    - name: dnf-plugins-core

grab_repo:
  cmd.run:
    - name: 'dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo'
    - require:
      - pkg: dnf-plugins-core

docker-ce:
  pkg.installed:
    - name: docker-ce
    - require:
      - cmd: grab_repo

start_docker:
  service.running:
    - name: docker
    - enable: True
    - require:
      - pkg: docker-ce

{% elif grains['os'] != "Fedora" %}
not_fedora:
  cmd.run:
    - name: '/usr/bin/echo "This is not a Fedora Server"'
{% endif %}