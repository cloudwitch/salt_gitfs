#installs oh-my-zsh
#some code borrowed from my buddy Logan
{% for user, args in pillar['users'].iteritems() %}
make-sure-deps-installed:
    pkg.installed:
        - pkgs: 
            - wget
            - zsh
            - git

check if installed:
  file.exists:
    name: /home/{{ user }}/.oh-my-zsh/README.md

#oh-my-zsh will get installed if it hasn't been already installed.
install-zsh:
  cmd.run:
    - name: sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
    - runas: {{ user }}
    - onfail:
      - file: check if installed

apply-zshrc:
    file.managed:
        - name: /home/{{ user }}/.zshrc
        - source: salt://{{ slspath }}/files/zshrc

replace-user in .zshrc:
  file.managed:
    - name: /home/{{ user }}/.zshrc
    - match: "  export ZSH=/changeme/.oh-my-zsh"
    - contents: 
      - "  export ZSH=/home/{{ user }}/.oh-my-zsh"
    - mode: replace
    - require:
      - file: apply-zshrc
{% endfor %}