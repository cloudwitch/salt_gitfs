
#This state masks fierwalld on Fedora or CentOS.
{% if grains['os'] == "Fedora" or grains['os'] == "CentOS"%}
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

{% else %}
not_fedora:
  cmd.run:
    - name: '/usr/bin/echo "This is not a Fedora or CentOS Server"'
{% endif %}