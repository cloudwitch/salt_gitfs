# <add jinja to find IP to replace in <addr>

get consul:
  file.managed:
    {% if grains['cpuarch'] == 'x86_64' and grains['kernel'] == 'Linux'%}
    - name: /tmp/consul_1.2.2_linux_amd64.zip
    - source: https://releases.hashicorp.com/consul/1.2.2/consul_1.2.2_linux_amd64.zip
    {% elif grains['cpuarch'] == 'armv7l' and grains['kernel'] == 'Linux'%}
    - name: /tmp/consul_1.2.2_linux_arm.zip
    - source: https://releases.hashicorp.com/consul/1.2.2/consul_1.2.2_linux_arm.zip
    {% endif %}
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
    {% if grains['cpuarch'] == 'x86_64' and grains['kernel'] == 'Linux'%}
    - source: /tmp/consul_1.2.2_linux_amd64.zip
    {% elif grains['cpuarch'] == 'armv7l' and grains['kernel'] == 'Linux'%}
    - source: /tmp/consul_1.2.2_linux_arm.zip
    {% endif %}

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
    - user: root
    - group: root

consul:
  service.running:
    - enable: True
    - reload: True
    - require:
      - file: setup console service
      - archive: unzip consul
      - file: change addr

copy consul config:
  file.managed:
    - name:  /etc/consul.d/config.json
    - source: salt://{{slspath}}/files/config.json
    - mode: 644
    - makedirs: True
    - user: consul
    - group: consul
    - require:
      - user: consul user

change addr:
  file.replace:
    - name: /etc/consul.d/config.json
    - pattern: <addr>
    - repl: {{ salt.cmd.run('nslookup ') }}
    - require:
      - file: copy consul config