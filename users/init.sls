fam:
  group.present:
    - gid: 101012

travis:
  user.present:
    - fullname: Travis
    - shell: /usr/bin/zsh
    - uid: 10101
    - groups:
      - wheel
      - fam