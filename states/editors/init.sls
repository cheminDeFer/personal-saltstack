# init all states below
install_editors:
  pkg.installed:
    - pkgs:
      - vim-nox
install_vimrc:
  file.managed:
    - name: /home/hsyn/.vimrc
    - makedirs: True
    - source: salt://states/editors/.vimrc
    - user: hsyn

