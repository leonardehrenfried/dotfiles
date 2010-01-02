from __future__ import with_statement
from fabric.api import *
from fabric.contrib.console import confirm
import os
from datetime import date

env.hosts=['quasar.webhostserver.biz']
env.user="lenniboy"
    
timestamp=str(date.today())

def wp_upgrade():
    "Upgrade wordpress"
    run('mkdir ~/wpupgrade/%d' % timestamp)
    run('mkdir ~/wpupgrade/bac/%d', timestamp)
    run('wget http://wordpress.org/latest.tar.gz -O ~/wpupgrade/%d/latest.tar.gz'% timestamp)
    run('tar -C /home/wpupgrade/%d/ -xvzf ~/wpupgrade/%d/latest.tar.gz' % timestamp, timestamp)
    run('cp -R /home/lenniboy/www/blog ~/wpupgrade/bac/%d/' % timestamp)
    sudo('cp -R ~/wpupgrade/%d/wordpress/* /home/lenniboy/www/blog'% timestamp)
    sudo('chown -R /home/lenniboy/www/blog')