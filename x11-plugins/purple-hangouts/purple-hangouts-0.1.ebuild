# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

#EHG_REPO_URI="https://bitbucket.org/EionRobb/purple-hangouts"
#inherit mercurial multilib
inherit multilib

DESCRIPTION="Hangouts Plugin for libpurple"
HOMEPAGE="https://bitbucket.org/EionRobb/purple-hangouts/"

SRC_URI="http://dwarf-planet-project.github.io/purple-hangouts-0.1.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND=">=dev-libs/protobuf-c-1.1.1
	dev-libs/json-glib
	dev-libs/nss
	sys-libs/zlib
	>=net-im/pidgin-2.10.12
	net-libs/libaccounts-glib"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_compile() {
	emake CC=$(tc-getCC)
}

src_install() {
	dodir /usr/$(get_libdir)/purple-2
	dodir /usr/share/pixmaps/pidgin/protocols/{16,22,24,48}
	default
}
