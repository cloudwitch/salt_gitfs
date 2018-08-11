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

#setup_remote_port_55000:
#  file.managed:
#    - name: /etc/docker/daemon.json
#    - source: salt://{{slspath}}/files/daemon.json
#    - source_hash: c77f4717b998ce5b41fe67f5b99e0f0808d9b12c2ca75e23d1d1cb8e3f6cef26
#    - makedirs: True
#    - user: root
#    - group: root
#    - mode: 600

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