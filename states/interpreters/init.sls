
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
#bootstrap_virtualenv:
#  cmd.run:
#    - name: 'curl --silent --location --output /tmp/virtualenv.pyz https://bootstrap.pypa.io/virtualenv.pyz'
