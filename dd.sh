#!/bin/bash
GIT_SSH_COMMAND="ssh -o StrictHostKeyChecking=no" git clone git@github.com:BKopyl/ml-cluster.git /home/ec2-user/

bash /home/ec2-user/dd.sh
