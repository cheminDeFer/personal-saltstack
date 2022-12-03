
install_python:
  pkg.installed:
    - pkgs:
      - python3-dev
      - python3-distutils
{% set pyscripts = ['pip', 'virtualenv', 'tox']%}
{% for pyscript in pyscripts%}
symlink_{{pyscript}}:
  file.symlink:
    - name: '/home/hsyn/bin/{{pyscript}}'
    - target: '/home/hsyn/opt/venv/bin/{{pyscript}}'
    - user: 'hsyn'
    - makedirs: True
{% endfor %}
# fixme should unless option be more clever?
bootstrap_virtualenv:
  cmd.script:
    - name: 'installoptvenv'
    - source: 'salt://states/interpreters/installoptvenv'
    - env:
      - venv: "/home/hsyn/opt/venv"
    - require:
      - install_python
    - unless: test -d "/home/hsyn/opt/venv"
    - runas: 'hsyn'
