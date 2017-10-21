
#This state masks fierwalld on fedora.
{% if grains['os'] == "Fedora" %}
kill_firewalld:
  service.dead:
    - name: firewalld

mask_firewalld:
  service.masked:
    - name: firewalld
reboot_suggestion:
  cmd.run:
    - name: '/usr/bin/echo "You should probably reboot now"'
    - require:
      - service: mask_firewalld
      - service: kill_firewalld

{% elif grains['os'] != "Fedora" %}
not_fedora:
  cmd.run:
    - name: '/usr/bin/echo "This is not a Fedora Server"'
{% endif %}