# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
EGO_PN=github.com/xenserver/packer-builder-xenserver

if [[ ${PV} = *999* ]]; then
	inherit golang-vcs git-r3
	EGIT_REPO_URI="git://github.com/xenserver/packer-builder-xenserver.git"
else
	KEYWORDS="~amd64 ~arm ~arm64"
	EGIT_COMMIT="v${PV}"
	SRC_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	inherit golang-vcs-snapshot
fi
inherit golang-build

DESCRIPTION="A builder plugin for Packer.IO to support building XenServer images."
HOMEPAGE="https://www.xenserver.org"
LICENSE="MPL-2"
SLOT="0"
IUSE=""
DEPEND="dev-go/packer
		dev-go/gox"
RDEPEND="dev-go/packer"

src_fetch(){
	git-r3_src_fetch
}

src_unpack(){
	git-r3_checkout
}

src_compile() {
	cd ${WORKDIR}
	./build.sh
}
