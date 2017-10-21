standard_programs:
  pkg.installed:
  - pkgs:
    - salt-minion
    - htop
    - sl

vim:
  pkg.installed:
 {% if grains['os'] == "CentOS" or grains['os'] == "Fedora" %}
    - pkgs:
      - vim-enhanced
{% elif grains['os'] != "CentOS" or grains['os'] != "Fedora" %}
    - pkgs:
      - vim
{% endif %}
