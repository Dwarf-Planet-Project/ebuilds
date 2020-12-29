# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit eutils

DESCRIPTION="A terminal-based remote package update manager for .deb and .rpm based Linux Distributions"
HOMEPAGE="http://www.ibh.de/apt-dater"
SRC_URI="https://github.com/hoehnp/apt-dater/archive/v${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="procmail lockfile-progs tcl xml"

DEPEND="
    dev-util/pkgconfig
    sys-libs/glibc
    dev-libs/glib
    sys-libs/ncurses
    dev-libs/popt
    xml? ( dev-libs/libxml2 )
    procmail? ( mail-filter/procmail )
    lockfile-progs? ( app-misc/lockfile-progs )
    net-misc/openssh
    app-misc/screen
    tcl? ( dev-lang/tcl )"

REQUIRED_USE="
    procmail? ( !lockfile-progs )
    !lockfile-progs? ( procmail ) 
    lockfile-progs? ( !procmail )
    !procmail? ( lockfile-progs ) 
"
    
src_configure() {
    econf \
        $(use_enable tcl tclfilter) \
        $(use_enable xml xmlreport) 
}

src_install() {
    emake DESTDIR="${D}" install
	pwd
}
