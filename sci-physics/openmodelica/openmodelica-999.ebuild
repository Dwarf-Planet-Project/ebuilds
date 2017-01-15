# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit autotools java-pkg-2 git-r3

DESCRIPTION="The Open Source Modelica Compiler"
HOMEPAGE="https://openmodelica.org"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=" <dev-java/antlr-3.0
	dev-vcs/subversion
	virtual/jdk:1.7
	dev-libs/boost
	dev-libs/boehm-gc[threads]
	sys-devel/autoconf:2.5
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
	sys-libs/readline:0
	sys-devel/clang
	dev-lang/perl[ithreads]"

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
	virtual/jre:1.7"

EGIT_REPO_URI="https://github.com/OpenModelica/OpenModelica.git"

src_prepare() {
# patch configure.in to force bootstraping of omc, as rebuild without bootstraping causes sandbox problems
# check for path /home/adrpo/om/Compiler/ in source files
	sed -i "s,which\ omc,," ./configure.in
	sed -i "s/$ORIGIN/${D}/" ./configure.in

	eapply_user

	eautoreconf
}

src_configure() {
	local myeconfargs=(
					--with-paradiseo
					--with-METIS=/usr/lib/
					--with-omniORB=/usr
					--enable-OMNotebook
					--without-omc
					--prefix="${WORKDIR}"
					--exec-prefix="${WORKDIR}"
					--with-ombuilddir="${WORKDIR}"
					--with-openmodelicahome="${WORKDIR}"
	)
	econf $myeconfargs
}

src_compile() {

	emake
	emake mosh
	emake qtclients

}

#src_test() {
#	emake test
#}

src_install() {

	emake DESTDIR="${D}" install

}
