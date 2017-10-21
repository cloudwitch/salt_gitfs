#This state sets up tuned
{% if grains['virtual'] == "kvm" and grains['os'] != "Debian"%}
tuned:
  pkg.installed:
    - pkgs:
      - tuned

start_tuned:
  service.running:
    - name: tuned
    - enable: True
    - require:
       - pkg: tuned

virtual_tuned:
  tuned.profile:
    - name: virtual-guest
    - require:
      - service: start_tuned

{% elif grains['virtual'] == "physical" %}
tuned:
  pkg.installed:
    - pkgs:
      - tuned

start_tuned:
  service.running:
    - name: tuned
    - enable: True
    - require:
       - pkg: tuned

physical_tuned:
  tuned.profile:
    - name: throughput-performance
    - require: 
      - service: start_tuned

{% elif grains['virtual'] == "kvm" and grains['os'] == "Debian"%}
debian:
  cmd.run:
    - name: '/usr/bin/echo "No tuned for you!!!"'

{% endif %}