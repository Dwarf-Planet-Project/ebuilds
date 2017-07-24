# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
EGO_PN=golang.org/x/fmt

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	KEYWORDS="~amd64 ~arm ~arm64"
	EGIT_COMMIT="v${PV}"
	SRC_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	inherit golang-vcs-snapshot
fi
inherit golang-build

DESCRIPTION="Gofmt formats Go programs. It uses tabs (width = 8) for indentation and blanks for alignment."
HOMEPAGE="https://www.golang.org"
LICENSE="BSD-3"
SLOT="0"
IUSE=""
DEPEND="dev-lang/go"
RDEPEND="dev-lang/go"
