# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
EGO_PN=github.com/xenserver/packer-builder-xenserver/builder/xenserver/xva

if [[ ${PV} = *999* ]]; then
	inherit golang-vcs git-r3
	EGIT_REPO_URI="https://github.com/xenserver/packer-builder-xenserver.git"
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

src_unpack(){
	_golang-vcs_env_setup
	ego_pn_check
	set -- env GOROOT="/usr/lib/go-gentoo"

	if [[ -z ${EVCS_OFFLINE} ]]; then
		[[ -n ${EVCS_UMASK} ]] && eumask_push ${EVCS_UMASK}

		set -- env GOPATH="${EGO_STORE_DIR}" go get -d -t -u -v -x "${EGO_PN}"
		echo "$@"
		git-r3_src_unpack
		# The above dies if you pass repositories in EGO_PN instead of
		# packages, e.g. golang.org/x/tools instead of golang.org/x/tools/cmd/vet.
		# This is being discussed in the following upstream issue:
		# https://github.com/golang/go/issues/11090

		[[ -n ${EVCS_UMASK} ]] && eumask_pop
	fi
}

src_compile() {
	./build.sh
}
