# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 qmake-utils

DESCRIPTION="NavitConfigurator is a third party application for editing the navit.xml file on your PC"
HOMEPAGE=""http://sourceforge.net/p/navitconfigurat/wiki/Wiki%20for%20NavitConfigurator/
SRC_URI=""

EGIT_REPO_URI="git://git.code.sf.net/p/navitconfigurat/code"

LICENSE="LGPL3"
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

