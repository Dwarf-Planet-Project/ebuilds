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
LICENSE="MPL-2.0"
SLOT="0"
IUSE=""
DEPEND="dev-go/packer
		dev-go/gox
		dev-go/go-vnc
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
}

src_prepare(){
	sed -i -e "s,mitchellh/packer/,hashicorp/packer/,g" ${EGIT_CHECKOUT_DIR}/plugin/builder-xenserver-*/main.go
	eapply_user
}

src_compile() {
	ls -lah
	cp -r src/github.com/xenserver/packer-builder-xenserver/* .
	export GOPATH="/usr/lib/go-gentoo/:/usr/lib/go/:${GOPATH}:${WORKDIR}/${P}"

	XC_OS=${XC_OS:-$(go env GOOS)}
	XC_ARCH=${XC_ARCH:-$(go env GOARCH)}
	GOPATH=${GOPATH:-$(go env GOPATH)}


	gox \
    -os="${XC_OS}" \
    -arch="${XC_ARCH}" \
    -output "pkg/{{.OS}}_{{.Arch}}/packer-{{.Dir}}" \
    ./... \
    || exit 1

	# Move all the compiled things to the $GOPATH/bin
	GOPATH=${GOPATH:-$(go env GOPATH)}
	
	OLDIFS=$IFS
	IFS=: MAIN_GOPATH=($GOPATH)
	IFS=$OLDIFS

# Copy our OS/Arch to the bin/ directory
	echo "==> Copying binaries for this platform..."
	DEV_PLATFORM="./pkg/$(go env GOOS)_$(go env GOARCH)"
	for F in $(find ${DEV_PLATFORM} -mindepth 1 -maxdepth 1 -type f); do
    	cp ${F} bin/
    	cp ${F} ${MAIN_GOPATH}/bin/
	done

}
