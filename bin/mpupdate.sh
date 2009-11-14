#!/bin/bash

sudo port -v selfupdate
sudo port upgrade outdated
sudo port clean --all installed
sudo port -f uninstall inactive