indep_binaries := $(indep_binaries) gcc-source

p_source = gcc$(pkg_ver)-source
d_source= debian/$(p_source)

$(binary_stamp)-gcc-source:
	dh_testdir
	dh_testroot

	dh_install -p$(p_source) $(gcc_tarball) usr/src/gcc$(pkg_ver)
	#dh_install -p$(p_source) debian/patches usr/src/gcc$(pkg_ver)/debian/patches
	dh_install -p$(p_source) \
		`find debian/ -type f -maxdepth 1` \
		debian/rules.d debian/patches \
		usr/src/gcc$(pkg_ver)/debian
	chmod 755 debian/$(p_source)/usr/src/gcc$(pkg_ver)/debian/patches/*
	rm -rf debian/$(p_source)/usr/src/gcc$(pkg_ver)/debian/{patches,rules.d}/.svn
	#    debian/rules.defs debian/rules.patch debian/rules \
	#    debian/rules2 debian/rules.conf \
	#    debian/rules.unpack \
	#	usr/src/gcc$(pkg_ver)/debian

	debian/dh_doclink -p$(p_source) $(p_base)

	dh_fixperms -p$(p_source)
	dh_gencontrol -p$(p_source) -- -v$(DEB_VERSION) $(common_substvars)
	dh_installdeb -p$(p_source)
	dh_md5sums -p$(p_source)
	dh_builddeb -p$(p_source)

	touch $@
