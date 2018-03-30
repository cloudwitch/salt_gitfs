#installs oh-my-zsh
#borrowed from my buddy Logan
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
        - name: /home/fiona/.zshrc
        - source: salt://{{ slspath }}/files/zshrc
