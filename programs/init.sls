programs:
  pkg.installed:
  - pkgs:
    - salt-minion
    - htop
{% if grains['os'] == "CentOS" or grains['os'] == "Fedora" %}
  - pkgs:
    - vim-enhanced
{% elif grains['os'] != "CentOS" or grains['os'] != "Fedora" %}
  - pkgs: vim
{% endif %}
