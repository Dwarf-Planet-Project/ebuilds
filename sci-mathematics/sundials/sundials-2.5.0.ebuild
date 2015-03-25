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
IUSE=""
DEPEND=""
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
}

src_configure() {

	econf  
		  
}

src_compile() {

	emake 

}

src_install() {

#	emake install " --prefix=/${D}"
	einstall

}
