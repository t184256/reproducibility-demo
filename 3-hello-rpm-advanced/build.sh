#!/usr/bin/env bash
set -uex

# shortcut for `reprotest ../hello.src.rpm --variations=aslr,environment,exec_path,fileordering,home,locales,num_cpus,umask`

reprotest ../hello.src.rpm -f reprotest.conf  # works

# Now this fails:
#reprotest ../hello.src.rpm --config reprotest.conf --vary build_path

# And this fails from time to time:
#reprotest ../hello.src.rpm --config reprotest.conf --vary time

# use --store-dir=out to take a look at the artifacts
