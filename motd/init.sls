motd:
  file.managed:
    name: /etc/motd
    source: {{ slspath }}/files/motd
    user: root
    group: root
    mode: 644