#!/usr/bin/env bash
set -uex

diff 1-hello-srpm/{1,2}/SRPMS/hello-*.src.rpm
diff -r 2-hello-rpm-manual/{1,2}/RPMS/x86_64

rm -rf reference-files
mkdir reference-files
cp 1-hello-srpm/1/SRPMS/hello-2.10-1.fc36.src.rpm reference-files/
cp -r 2-hello-rpm-manual/1/RPMS/x86_64 reference-files/
tar cf reference-files.tar reference-files

gh release upload --clobber reference-files reference-files.tar
