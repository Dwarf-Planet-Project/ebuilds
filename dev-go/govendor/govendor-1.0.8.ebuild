# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
EGO_PN=github.com/kardianos/${PN}

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	KEYWORDS="~amd64 ~arm ~arm64"
	EGIT_COMMIT="v${PV}"
	SRC_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	inherit golang-vcs-snapshot
fi
inherit golang-build

DESCRIPTION="Go vendor tool that works with the standard vendor file."
HOMEPAGE="https://github.com/kardianos/govendor"
LICENSE="BSD"
SLOT="0"
IUSE=""
DEPEND="dev-lang/go"
RDEPEND="dev-lang/go"
