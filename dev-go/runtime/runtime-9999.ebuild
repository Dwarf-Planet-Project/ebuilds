# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
EGO_PN=golang.org/pkg/runtime

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	KEYWORDS="~amd64 ~arm ~arm64"
	EGIT_COMMIT="v${PV}"
	SRC_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	inherit golang-vcs-snapshot
fi
inherit golang-build

DESCRIPTION="Package runtime contains operations that interact with Go's runtime 
			 system, such as functions to control goroutines. It also includes the 
			 low-level type information used by the reflect package; see reflect's 
			 documentation for the programmable interface to the run-time type system. "
HOMEPAGE="https://www.golang.org"
LICENSE="BSD-3"
SLOT="0"
IUSE=""
DEPEND="dev-lang/go"
RDEPEND="dev-lang/go"
