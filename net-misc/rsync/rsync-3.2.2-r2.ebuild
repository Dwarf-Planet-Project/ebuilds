# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic prefix systemd

DESCRIPTION="File transfer program to keep remote files into sync"
HOMEPAGE="https://rsync.samba.org/"
if [[ "${PV}" == *9999 ]] ; then
	PYTHON_COMPAT=( python3_{6,7,8,9,10,11} )
	inherit autotools git-r3 python-any-r1
	EGIT_REPO_URI="https://github.com/WayneD/rsync.git"
else
	if [[ "${PV}" == *_pre* ]] ; then
		SRC_DIR="src-previews"
	else
		SRC_DIR="src"
		KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~m68k ~mips ppc ppc64 ~riscv s390 sparc x86 ~ppc-aix ~x64-cygwin ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
	fi
	SRC_URI="https://rsync.samba.org/ftp/rsync/${SRC_DIR}/${P/_/}.tar.gz"
	S="${WORKDIR}/${P/_/}"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE_CPU_FLAGS_X86=" sse2"
IUSE="acl examples iconv ipv6 libressl lz4 ssl static stunnel system-zlib xattr xxhash zstd"
IUSE+=" ${IUSE_CPU_FLAGS_X86// / cpu_flags_x86_}"

LIB_DEPEND="acl? ( virtual/acl[static-libs(+)] )
	lz4? ( app-arch/lz4[static-libs(+)] )
	ssl? (
		!libressl? ( dev-libs/openssl:0=[static-libs(+)] )
		libressl? ( dev-libs/libressl:0=[static-libs(+)] )
	)
	system-zlib? ( sys-libs/zlib[static-libs(+)] )
	xattr? ( kernel_linux? ( sys-apps/attr[static-libs(+)] ) )
	xxhash? ( dev-libs/xxhash[static-libs(+)] )
	zstd? ( app-arch/zstd[static-libs(+)] )
	>=dev-libs/popt-1.5[static-libs(+)]"
RDEPEND="!static? ( ${LIB_DEPEND//\[static-libs(+)]} )
	iconv? ( virtual/libiconv )"
DEPEND="${RDEPEND}
	static? ( ${LIB_DEPEND} )"

if [[ "${PV}" == *9999 ]] ; then
	BDEPEND="${PYTHON_DEPS}
		$(python_gen_any_dep '
			dev-python/commonmark[${PYTHON_USEDEP}]
		')"
fi

PATCHES=(
#	"${FILESDIR}/${P}-allow_bwlimit_0.patch" #731306
	"${FILESDIR}/${P}-zstd_see_token.patch" #733084
#	"${FILESDIR}/${P}-CVE-2024-12084.patch"
    "${FILESDIR}/${P}-CVE-2024-12085.patch"
    "${FILESDIR}/${P}-CVE-2024-12086-1.patch"
    "${FILESDIR}/${P}-CVE-2024-12086-2.patch"
    "${FILESDIR}/${P}-CVE-2024-12087-1.patch"
    "${FILESDIR}/${P}-CVE-2024-12087-2.patch"
#    "${FILESDIR}/${P}-CVE-2024-12088.patch"
    "${FILESDIR}/${P}-CVE-2024-12747-1.patch"
    "${FILESDIR}/${P}-CVE-2024-12747-2.patch"
)

# Only required for live ebuild
python_check_deps() {
	has_version "dev-python/commonmark[${PYTHON_USEDEP}]"
}

src_prepare() {
	default
	if [[ "${PV}" == *9999 ]] ; then
		eaclocal -I m4
		eautoconf -o configure.sh
		eautoheader && touch config.h.in
	fi
}

src_configure() {
	use static && append-ldflags -static
	local myeconfargs=(
		--with-rsyncd-conf="${EPREFIX}"/etc/rsyncd.conf
		--without-included-popt
		$(use_enable acl acl-support)
		$(use_enable iconv)
		$(use_enable ipv6)
		$(use_enable lz4)
		$(use_enable ssl openssl)
		$(use_with !system-zlib included-zlib)
		$(use_enable xattr xattr-support)
		$(use_enable xxhash)
		$(use_enable zstd)
	)

	if use elibc_glibc && [[ "${ARCH}" == "amd64" ]] ; then
		# SIMD is only available for x86_64 right now
		# and only on glibc (#728868)
		myeconfargs+=( $(use_enable cpu_flags_x86_sse2 simd) )
	else
		myeconfargs+=( --disable-simd )
	fi

	econf "${myeconfargs[@]}"
	[[ "${PV}" == *9999 ]] || touch proto.h-tstamp #421625
}

src_install() {
	emake DESTDIR="${D}" install

	newconfd "${FILESDIR}"/rsyncd.conf.d rsyncd
	newinitd "${FILESDIR}"/rsyncd.init.d-r1 rsyncd

	dodoc NEWS.md README.md TODO tech_report.tex

	insinto /etc
	newins "${FILESDIR}"/rsyncd.conf-3.0.9-r1 rsyncd.conf

	insinto /etc/logrotate.d
	newins "${FILESDIR}"/rsyncd.logrotate rsyncd

	insinto /etc/xinetd.d
	newins "${FILESDIR}"/rsyncd.xinetd-3.0.9-r1 rsyncd

	# Install stunnel helpers
	if use stunnel ; then
		emake DESTDIR="${D}" install-ssl-daemon
	fi

	# Install the useful contrib scripts
	if use examples ; then
		exeinto /usr/share/rsync
		doexe support/*
		rm -f "${ED}"/usr/share/rsync/{Makefile*,*.c}
	fi

	eprefixify "${ED}"/etc/{,xinetd.d}/rsyncd*

	systemd_dounit "${FILESDIR}/rsyncd.service"
}

pkg_postinst() {
	if egrep -qis '^[[:space:]]use chroot[[:space:]]*=[[:space:]]*(no|0|false)' \
		"${EROOT}"/etc/rsyncd.conf "${EROOT}"/etc/rsync/rsyncd.conf ; then
		ewarn "You have disabled chroot support in your rsyncd.conf.  This"
		ewarn "is a security risk which you should fix.  Please check your"
		ewarn "/etc/rsyncd.conf file and fix the setting 'use chroot'."
	fi
	if use stunnel ; then
		einfo "Please install \">=net-misc/stunnel-4\" in order to use stunnel feature."
		einfo
		einfo "You maybe have to update the certificates configured in"
		einfo "${EROOT}/etc/stunnel/rsync.conf"
	fi
	if use system-zlib ; then
		ewarn "Using system-zlib is incompatible with <rsync-3.1.1 when"
		ewarn "using the --compress option."
		ewarn
		ewarn "When syncing with >=rsync-3.1.1 built with bundled zlib,"
		ewarn "and the --compress option, add --new-compress (-zz)."
		ewarn
		ewarn "For syncing the portage tree, add:"
		ewarn "PORTAGE_RSYNC_EXTRA_OPTS=\"--new-compress\" to make.conf"
	fi
}
