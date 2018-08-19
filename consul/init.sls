get consul:
  file.managed:
    - name: /tmp/consul_1.2.2_linux_amd64.zip
    - source: https://releases.hashicorp.com/consul/1.2.2/consul_1.2.2_linux_amd64.zip
    - source_hash: https://releases.hashicorp.com/consul/1.2.2/consul_1.2.2_SHA256SUMS

consul group:
  group.present:
    - name: consul
    - system: True

consul user:
  user.present:
    - name: consul
    - fullname: Consul Service User
    - gid_from_name: True
    - createhome: False
    - shell: /bin/false
    - require:
      - group: consul group

unzip consul:
  archive.extracted:
    - name: /usr/local/bin/consul
    - source: /tmp/consul_1.2.2_linux_amd64.zip
    - user: consul
    - group: consul
    - keep_source: False
    - use_cmd_unzip: True
    - require:
      - file: get consul
      - user: consul user

chmod consul:
  file.managed:
    - name: /usr/local/bin/consul
    - mode: 755
    - require:
      - archive: unzip consul

setup console service:
  file.managed:
    - name:  /lib/systemd/system/consul.service
    - source: salt://{{slspath}}/files/consul.service
    - mode: 644

consul:
  service.running:
    - enable: True
    - reload: True
    - require:
      - file: setup console service
      - archive: unzip consul

copy consul config:
  file.managed:
    - name:  
    - source: salt://{{slspath}}/files/consul.service
    - mode: 644