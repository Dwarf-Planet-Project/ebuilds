# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="SUite of Nonlinear and DIfferential/ALgebraic equation Solvers"
HOMEPAGE="http://computation.llnl.gov/casc/sundials/main.html"
SRC_URI="http://ftp.mcs.anl.gov/pub/petsc/externalpackages/sundials-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="lapack mpi cvode cvodes ida idas kinsol cpodes"
DEPEND="lapack? ( sci-libs/lapack-reference )"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
}

src_configure() {

    econf \
		  $( use_enable lapack) \
		  $( use_enable mpi)    \
		  $( use_enable cvode)  \
		  $( use_enable cvodes) \
		  $( use_enable ida)    \
		  $( use_enable idas)   \
		  $( use_enable kinsol) \
		  $( use_enable cpodes) \
		  "--disable-static --enable-shared"
		  
}

src_compile() {

	emake 

}

src_install() {

	emake install

}
