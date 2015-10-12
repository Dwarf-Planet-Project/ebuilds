# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit subversion autotools java-pkg-2

DESCRIPTION="The Open Source Modelica Compiler"
HOMEPAGE="https://openmodelica.org"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=" <dev-java/antlr-3.0 
        dev-vcs/subversion 
		>=virtual/jdk-1.7
		dev-libs/boost 
		dev-libs/boehm-gc[threads]
		sys-devel/autoconf 
		sci-mathematics/paradiseo-bin
		dev-util/nvidia-cuda-toolkit
		sys-devel/autoconf-wrapper
		sci-libs/lis
		x11-libs/gtkglext
		dev-games/openscenegraph
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
		 sci-libs/umfpack
		 >=virtual/jre-1.7"

ESVN_REPO_URI="https://openmodelica.org/svn/OpenModelica/trunk/"

src_prepare() {
# patch configure.in to force bootstraping of omc, as rebuild without bootstraping causes sandbox problems
# check for path /home/adrpo/om/Compiler/ in source files
	epatch "${WORKDIR}/patch1"
	sed -i "s,which\ omc,," ./configure.in
	sed -i "s/$ORIGIN/${D}/" ./configure.in
	eautoreconf
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

	emake omc
	emake mosh
	emake qtclients
	
}


src_test() {
	emake test
}


src_install() {
	
	emake DESTDIR="${D}" install	
	
}

