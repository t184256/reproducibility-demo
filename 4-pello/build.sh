#!/usr/bin/env bash
set -uex

[[ -e pello-0.1.1.tar.gz ]] || \
	wget https://github.com/redhat-developer/rpm-packaging-guide/raw/master/example-code/pello-0.1.1.tar.gz

rm -rf 1 2
for I in 1 2; do
	mkdir -p $I/SOURCES/
	ln pello-0.1.1.tar.gz $I/SOURCES/
	rpmbuild \
		--define "%_topdir $(pwd)/$I/" \
		--define '%use_source_date_epoch_as_buildtime 1' \
		--define '%clamp_mtime_to_source_date_epoch 1' \
		--define '%source_date_epoch_from_changelog 1' \
		--define '%_buildhost localhost' \
		-bs pello.spec
done

diff -rs 1/SRPMS 2/SRPMS || \
	diffoscope 1/SRPMS/*.src.rpm 2/SRPMS/*.src.rpm

echo back-to-back SRPM reproducibility achieved
ln -f 1/SRPMS/*.src.rpm ../pello.src.rpm


# exhibits all kinds of weirdness - timestmaps, /bin/bash vs /usr/bin/bash...
reprotest ../pello.src.rpm \
	--variations=aslr,environment,exec_path,fileordering,home,locales,num_cpus,umask,time,timezone
echo back-to-back RPM reproducibility achieved
