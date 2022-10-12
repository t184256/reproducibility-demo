#!/usr/bin/env bash
set -uex

rm -rf 1 2
for I in 1 2; do
	rpmbuild \
		--define "%_topdir $(pwd)/$I/" \
		--define '%use_source_date_epoch_as_buildtime 1' \
		--define '%clamp_mtime_to_source_date_epoch 1' \
		--define '%source_date_epoch_from_changelog 1' \
		--define '%_buildhost localhost' \
	        -ra ../hello.src.rpm
	sleep 1
done

for RPM in $(cd 1/RPMS/x86_64 && ls); do
	diffoscope 1/RPMS/x86_64/$RPM 2/RPMS/x86_64/$RPM
done
diff -rs 1/RPMS 2/RPMS

echo back-to-back RPM reproducibility achieved


############################## make it work! ###################################


############################## hints ###########################################


# see solution.sh
