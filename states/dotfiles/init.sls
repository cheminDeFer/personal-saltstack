# init all states below

tmux_conf:
  file.managed:
  - name: /home/hsyn/.tmux.conf
  - source: salt://states/dotfiles/.tmux.conf
  - user: hsyn
bash_conf:
  file.managed:
  - name: /home/hsyn/.bashrc
  - source: salt://states/dotfiles/.bashrc
  - user: hsyn
