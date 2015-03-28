# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils libtool

DESCRIPTION="SUite of Nonlinear and DIfferential/ALgebraic equation Solvers"
HOMEPAGE="http://computation.llnl.gov/casc/sundials/main.html"
SRC_URI="http://ftp.mcs.anl.gov/pub/petsc/externalpackages/sundials-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
DEPEND=""
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
}

src_configure() {

	#econf F77=gfortran --prefix=/usr --disable-mpi --enable-shared --disable-static

    local mycmakeargs=(
	                   -DCMAKE_INSTALL_PREFIX=/usr F77=gfortran --disable-mpi --enable-shared --disable-static -fPIC
	)

	 cmake-utils_src_configure

}

src_compile() {

	 cmake-utils_src_compile

}

src_test() {

	 cmake-utils_src_test

}

src_install() {

	elibtoolize
	cmake-utils_src_install

}
