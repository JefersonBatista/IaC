#!/bin/bash

# Go home directory
cd /home/ubuntu

# Install Ansible
sudo apt update
sudo apt install --yes software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install --yes ansible-core

# Write playbook
tee -a playbook.yml > /dev/null << EOF
- hosts: localhost
  tasks:
    - name: Install Python3 and VirtualEnv
      become: yes
      apt:
        update_cache: yes
        pkg:
          - python3
          - virtualenv
    - name: Verify project existence
      stat:
        path: /home/ubuntu/tcc/setup/settings.py
      register: project
    - name: Clone project
      git:
        repo: https://github.com/JefersonBatista/clientes-leo-api
        dest: /home/ubuntu/tcc
        version: master
        force: yes
      when: not project.stat.exists
    - name: Install dependencies with pip (Django and Django Rest)
      pip:
        virtualenv: /home/ubuntu/tcc/venv
        requirements: /home/ubuntu/tcc/requirements.txt
    - name: Set allowed hosts of the project
      lineinfile:
        path: /home/ubuntu/tcc/setup/settings.py
        regexp: ALLOWED_HOSTS
        line: 'ALLOWED_HOSTS = ["*"]'
        backrefs: yes
    - name: Configure database
      shell: '. /home/ubuntu/tcc/venv/bin/activate; python3 /home/ubuntu/tcc/manage.py migrate'
    - name: Load the data
      shell: '. /home/ubuntu/tcc/venv/bin/activate; python3 /home/ubuntu/tcc/manage.py loaddata clientes.json'
    - name: Run the project
      shell: 'cd /home/ubuntu/tcc; . venv/bin/activate; nohup python3 manage.py runserver 0.0.0.0:8000 &'
EOF

# Run playbook
ansible-playbook playbook.yml
