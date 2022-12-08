#!/usr/bin/bash

set -uex

rm -rf reference-files.tar reference-files
wget -q https://github.com/t184256/reproducibility-demo/releases/download/reference-files/reference-files.tar
tar xf reference-files.tar

diffoscope {reference-files,1-hello-srpm/1/SRPMS}/hello-2.10-1.fc36.src.rpm
diff {reference-files,1-hello-srpm/1/SRPMS}/hello-2.10-1.fc36.src.rpm
echo 'Inter-computer source RPM reproducibility achieved'

for RPM in $(cd reference-files/x86_64 && ls); do
	diffoscope {reference-files,2-hello-rpm-manual/1/RPMS}/x86_64/$RPM
	diff {reference-files,2-hello-rpm-manual/1/RPMS}/x86_64/$RPM
done
echo 'Inter-computer binary RPM reproducibility achieved'
