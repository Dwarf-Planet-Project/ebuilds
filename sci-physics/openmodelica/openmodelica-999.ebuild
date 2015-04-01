# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit subversion autotools

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
		sci-mathematics/paradiseo
		dev-util/nvidia-cuda-toolkit
		sys-devel/autoconf-wrapper
		sci-libs/lis
		x11-libs/gtkglext
		dev-games/openscenegraph
		sys-apps/hwloc
		dev-libs/msgpack
		dev-qt/qtgui:4
		dev-qt/qtcore:4
		dev-qt/qtsvg:4
		dev-qt/qtwebkit:4
		sci-libs/hdf5
		sys-libs/readline"

RDEPEND="${DEPEND} 
		 sci-mathematics/lpsolve 
		 dev-db/sqlite 
		 net-misc/omniORB  
		 x11-libs/qwt:6 
		 sci-libs/blas-reference 
		 sci-libs/lapack-reference 
		 dev-libs/ocl-icd  
		 sci-mathematics/sundials 
		 sci-libs/metis
		 sci-libs/ipopt
		 sci-libs/umfpack"

ESVN_REPO_URI="https://openmodelica.org/svn/OpenModelica/trunk/"


src_unpack() {

	subversion_src_unpack
}

src_prepare() {
# patch configure.in to force bootstraping of omc, as rebuild without bootstraping causes sandbox problems
	sed -i "s,which\ omc,," ./configure.in
	sed -i "s/$ORIGIN/${D}/" ./configure.in
	eautoconf
}

src_configure() {
	local myeconfargs=(
					--with-paradiseo
					--with-METIS=/usr/lib/
					--with-omniORB=/usr/lib/
					--enable-OMNotebook
	)
	econf $myeconfargs
}


src_compile() {
	emake 
}

src_test() {
	emake test
}

src_install() {
	emake DESTDIR="${D}" install	
}




