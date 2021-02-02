# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit autotools

DESCRIPTION="A Fast Fourier Transform (FFT) library that tries to Keep it Simple, Stupid"
HOMEPAGE="https://github.com/mborgerding/kissfft"
# QA checks don't like HOMEPAGE to be used in SRC_URI it seems
BASE_URI="https://github.com/mborgerding/kissfft"

LICENSE="BSD"
IUSE="test"
SLOT="0"
RESTRICT="!test? ( test )"

if [[ ${PV} == *9999 ]] ; then
	EGIT_REPO_URI="${BASE_URI}"
	inherit git-r3
else
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DEPEND=""
RDEPEND=""

src_install() {
	dolib.so libkissfft.so
	doheader kiss_fft.h
}

src_test() {
	make -C test testcpp && test/testcpp || die
	make -C test DATATYPE=simd test || die
}
