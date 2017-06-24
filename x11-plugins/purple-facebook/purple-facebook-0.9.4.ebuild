# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/purple-facebook/purple-facebook-20150718.ebuild,v 1.1 2015/07/20 16:02:15 chainsaw Exp $

EAPI=5

inherit eutils autotools

S="${WORKDIR}/${P}-c9b74a765767"
DESCRIPTION="Facebook protocol plugin for libpurple"
HOMEPAGE="https://github.com/dequis/purple-facebook"
SRC_URI="https://github.com/dequis/purple-facebook/archive/v${PV}-c9b74a765767.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="net-im/pidgin
		dev-libs/json-glib"
DEPEND="${RDEPEND}"
DOCS=( AUTHORS ChangeLog NEWS README VERSION )

src_prepare() {
 ./autogen.sh
}

src_install() {
	dodir /usr/lib/purple-2
	cp "${S}/pidgin/libpurple/protocols/facebook/.libs/libfacebook.so" "${D}"

}
