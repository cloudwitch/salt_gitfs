#installs oh-my-zsh
#borrowed from my buddy Logan
{% for user, args in pillar['users'].iteritems() %}
make-sure-deps-installed:
    pkg.installed:
        - pkgs: 
            - wget
            - zsh
            - git

install-zsh:
    cmd.run:
        - name: sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

apply-zshrc:
    file.managed:
        - name: /home/{{ user }}/.zshrc
        - source: salt://{{ slspath }}/files/zshrc

replace-user in .zshrc:
  file.replace:
    - name: /home/{{ user }}/.zshrc
    - pattern: ZSH=/changeme
    - repl: ZSH=/home/{{ user }}
    - require:
      - file: apply-zshrc
{% endfor %}