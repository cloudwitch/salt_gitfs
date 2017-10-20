users:
  travis:
    user.present:
      - fullname: Travis
      - home: /home/travis
      - shell: /usr/bin/bash
      - uid: 10101
      - gid: 101012
      - groups:
        - wheel
        - fam
        - docker
