#!/bin/bash

ansible-playbook -vvv -i hosts pgonly.yml --extra-vars "upassword=$WATERGUI_DATABASE_PASSWORD"
