motd:
  file.managed:
    name: /etc/motd
    source: salt://{{slspath}}/files/motd
    user: root
    group: root
    mode: 644
