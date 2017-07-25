# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
EGO_PN=github.com/xenserver/packer-builder-xenserver/builder/xenserver/xva

if [[ ${PV} = *999* ]]; then
	inherit golang-vcs git-r3
	EGIT_REPO_URI="https://github.com/xenserver/packer-builder-xenserver.git"
	EGIT_CHECKOUT_DIR=${WORKDIR}/${P}/src/github.com/xenserver/packer-builder-xenserver
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
		dev-go/gox
		"
RDEPEND="dev-go/packer"

src_unpack(){
	_golang-vcs_env_setup
	ego_pn_check

	if [[ -z ${EVCS_OFFLINE} ]]; then
		[[ -n ${EVCS_UMASK} ]] && eumask_push ${EVCS_UMASK}

		echo "$@"
		git-r3_src_unpack

		[[ -n ${EVCS_UMASK} ]] && eumask_pop
	fi
	sed -i -e "s,mitchellh/packer/,hashicorp/packer/,g" ${WORKDIR}/packer-xenserver-${PV}/plugin/builder-xenserver-*/main.go
}

src_compile() {
	export GOPATH="/usr/lib/go-gentoo/:/usr/lib/go/:${GOPATH}:${WORKDIR}/${P}"
	./build.sh
}

