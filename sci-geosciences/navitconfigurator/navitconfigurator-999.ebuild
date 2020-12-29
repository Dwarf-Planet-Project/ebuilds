# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 qmake-utils

DESCRIPTION="NavitConfigurator is a 3rd party app for editing the navit.xml file on your PC"
HOMEPAGE=""https://sourceforge.net/p/navitconfigurat/wiki/Wiki%20for%20NavitConfigurator/
SRC_URI=""

EGIT_REPO_URI="https://git.code.sf.net/p/navitconfigurat/code"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-qt/qtwebkit:5
		dev-util/android-tools"
RDEPEND="${DEPEND}"

src_prepare() {
	eqmake5
	eapply_user
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}
