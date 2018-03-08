#Add groups in pillar
{% for group, gid in pillar.get('groups', {}).items() %}
{{group}}:
  group.present:
    - gid: {{salt['pillar.get']('group:gid')}}
{% endfor %}