# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="an extensible Modelica-based open source platform for optimization, simulation and analysis of complex dynamic systems"
HOMEPAGE="jmodelica.org"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="superlu ipopt eclipse cppad"

DEPEND="superlu? ( sci-libs/superlu )
        ipopt? ( sci-libs/ipopt )
		eclipse? ( dev-util/eclipse-sdk-bin  )
		cppad? ( sci-libs/coinor-cppad )"
RDEPEND="${DEPEND}"

inherit subversion 

ESVN_REPO_URI="https://svn.jmodelica.org/tags/${PV}"


src_unpack() {
	subversion_src_unpack
}

src_configure() {
	
}
