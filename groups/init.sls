{% for user, gid in pillar.get('groups', {}).items() %}
{{group}}:
  group.present:
    - gid: {{gid}}
{% endfor %}