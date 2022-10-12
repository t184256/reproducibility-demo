#!/usr/bin/env bash
set -uex

[[ -e hello-2.10.tar.gz ]] || \
	wget https://ftp.gnu.org/gnu/hello/hello-2.10.tar.gz


rm -rf 1 2
for I in 1 2; do
	mkdir -p $I/SOURCES/
	ln hello-2.10.tar.gz $I/SOURCES/
	rpmbuild \
		--define "%_topdir $(pwd)/$I/" \
	        -bs hello.spec
done

diff -rs 1/SRPMS 2/SRPMS || \
	diffoscope 1/SRPMS/*.src.rpm 2/SRPMS/*.src.rpm

echo back-to-back SRPM reproducibility achieved
ln -f 1/SRPMS/*.src.rpm ../hello.src.rpm


############################## now let's make it harder ########################


# TODO: for extra complexity, add sleep 1 into the loop


############################## hints ###########################################


### pieces to reproducibility:

#   Sets RPMTAG_BUILDTIME from SOURCE_DATE_EPOCH
		#--define '%use_source_date_epoch_as_buildtime 1' \

#export SOURCE_DATE_EPOCH=$(git show -s --format=%ct HEAD)

#   If true, make sure that timestamps in built rpms
#   are not later than the value of SOURCE_DATE_EPOCH.
#   Is ignored when SOURCE_DATE_EPOCH is not set.
		#--define '%clamp_mtime_to_source_date_epoch 1' \

#   If true, set the SOURCE_DATE_EPOCH environment variable
#   to the timestamp of the topmost changelog entry
		#--define '%source_date_epoch_from_changelog 1' \

#   If set, the value of the build hostname in built rpms
#   uses the value of this macro instead of the actual
#   hostname of the machine that built the package.
		#--define '%_buildhost localhost' \
