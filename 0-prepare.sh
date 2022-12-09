#!/usr/bin/env bash
set -uex

rpm -q rpmbuild || sudo dnf -y install rpm-build
rpm -q diffoscope || sudo dnf -y install diffoscope
rpm -q disorderfs || sudo dnf -y install disorderfs
rpm -q reprotest || sudo dnf -y install reprotest
sudo dnf -y builddep 1-hello-srpm/hello.spec
