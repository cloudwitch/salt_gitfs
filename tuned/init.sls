#This state sets up tuned
{% if grains['virtual'] == "kvm" and grains['os'] != "Debian"%}
tuned:
  pkg.installed:
    - pkgs:
      - tuned

virtual_tuned:
  tuned.profile:
    - name: virtual-guest
    - require:
      - pkg: tuned

{% elif grains['virtual'] == "physical" %}
tuned:
  pkg.installed:
    - pkgs:
      - tuned

physical_tuned:
  tuned.profile:
    - name: throughput-performance
    - require: 
      - pkg: tuned

{% elif grains['virtual'] == "kvm" and grains['os'] == "Debian"%}
debian:
  cmd.run:
    - name: '/usr/bin/echo "No tuned for you!!!"'

{% endif %}