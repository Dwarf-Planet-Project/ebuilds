# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit subversion autotools-utils

DESCRIPTION="The Open Source Modelica Compiler"
HOMEPAGE="https://openmodelica.org"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=" <dev-java/antlr-3.0 
         dev-vcs/subversion 
		 dev-java/icedtea:7 
		 dev-libs/boost 
		 sys-devel/autoconf 
		 sci-mathematics/paradiseo-bin"

RDEPEND="${DEPEND} 
		 sci-mathematics/lpsolve 
		 dev-db/sqlite 
		 net-misc/omniORB  
		 x11-libs/qwt:6 
		 sci-libs/blas-reference 
		 sci-libs/lapack-reference 
		 dev-libs/ocl-icd  
		 dev-util/opencl-headers 
		 sci-mathematics/sundials 
		 sci-libs/metis"
# rml-mmc-999

ESVN_REPO_URI="https://openmodelica.org/svn/OpenModelica/trunk/"


src_unpack() {

	subversion_src_unpack
}


src_configure() {
	 autotools-utils_src_configure --with
}


src_compile() {
	cmake-utils_src_compile
}

src_test() {	
	cmake-utils_src_test
}

src_install() {
	cmake-utils_src_install
}




