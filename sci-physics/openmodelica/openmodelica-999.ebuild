# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit subversion 

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
		 dev-libs/boehm-gc[threads]
		 sys-devel/autoconf 
		 sci-mathematics/paradiseo-bin
		 dev-util/nvidia-cuda-toolkit
		 sys-devel/autoconf-wrapper
		 sci-libs/lis
		 x11-libs/gtkglext
		 dev-games/openscenegraph
		 sys-apps/hwloc"

RDEPEND="${DEPEND} 
		 sci-mathematics/lpsolve 
		 dev-db/sqlite 
		 net-misc/omniORB  
		 x11-libs/qwt:6 
		 sci-libs/blas-reference 
		 sci-libs/lapack-reference 
		 dev-libs/ocl-icd  
		 sci-mathematics/sundials 
		 sci-libs/metis"
# rml-mmc-999

ESVN_REPO_URI="https://openmodelica.org/svn/OpenModelica/trunk/"

AUTOTOOLS_IN_SOURCE_BUILD=1

LD_LIBRARY_PATH=/var/tmp/portage/sci-physics/openmodelica-999/work/openmodelica-999/build/bin/../lib/omc/:$LD_LIBRARY_PATH

src_unpack() {

	subversion_src_unpack
}

src_configure() {
	autoconf
	local myeconfargs=(
					--with-paradiseo
					--with-METIS=/usr/lib/
					--with-omniORB=/usr/lib/
					--disable-modelica3d
	)
	econf $myeconfargs
}


src_compile() {
	emake 
}

src_install() {
	emake DESTDIR="${D}" install	
}




