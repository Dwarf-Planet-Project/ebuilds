# Copyright 1999-2017 Gentoo Foundationjava-pkg-2
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit autotools   java-vm-2 git-r3

DESCRIPTION="The Open Source Modelica Compiler"
HOMEPAGE="https://openmodelica.org"
SRC_URI="" #https://github.com/OpenModelica/OpenModelica/archive/v${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="boost hdf5 hwloc java system-libexpat sundials corba qt4 qt5 omnotebook omshell omoptim"
REQUIRED_USE="omnotebook? ( corba )
			  omshell? ( corba )
			  omoptim? ( corba )"
RDEPEND="
	sci-mathematics/lpsolve
	corba? ( net-misc/omniORB )
	x11-libs/qwt:6
	sci-libs/blas-reference
	sci-libs/lapack-reference
	sundials? ( sci-libs/sundials )
	java? ( virtual/jre:1.8 )
	system-libexpat? ( dev-libs/expat )
	hwloc? ( sys-apps/hwloc )"

DEPEND=" ${RDEPEND}
	<dev-java/antlr-3.0
	java? ( virtual/jdk:1.8 )
	boost? ( dev-libs/boost )
	dev-libs/boehm-gc[threads]
	sys-devel/autoconf:2.5
	sci-mathematics/paradiseo-bin
	sys-devel/autoconf-wrapper
	sci-libs/lis
	x11-libs/gtkglext
	dev-games/openscenegraph
	qt5? ( dev-qt/qtgui:5
	dev-qt/qtcore:5
	dev-qt/qtsvg:5
	dev-qt/qtwebkit:5 )
	qt4? ( dev-qt/qtgui:4
	dev-qt/qtcore:4
	dev-qt/qtsvg:4
	dev-qt/qtwebkit:4 )
	hdf5? ( sci-libs/hdf5 )
	omshell? ( sys-libs/readline:0
	sys-libs/ncurses )
	sys-devel/clang
	dev-lang/perl[ithreads]
	dev-util/cmake"

EGIT_REPO_URI="https://github.com/OpenModelica/OpenModelica.git"
EGIT_BRANCH="maintenance/v1.11"
EGIT_COMMIT="b44575c9591e5f7eac1928e135ad12ea995c3237"

EGIT_SUBMODULES=("*")

#src_unpack() {
#    unpack ${A}
#
#	mv "${WORKDIR}/OpenModelica-${PV}" "${WORKDIR}/${P}"
#}

src_prepare() {
	eapply_user

	eautoreconf

	ased -i "s,https://openmodelica.org/git/SiemensPower.git,https://github.com/Dwarf-Planet-Project/SiemensPower.git," ./libraries/Makefile.libs
	sed -i "s,https://openmodelica.org/git/ThermoSysPro.git,https://github.com/Dwarf-Planet-Project/ThermoSysPro.git," ./libraries/Makefile.libs

}

src_configure() {
	local myeconfargs=(
					--prefix="${WORKDIR}"
					--exec-prefix="${WORKDIR}"
					--with-ombuilddir="${WORKDIR}"
					--with-openmodelicahome="${WORKDIR}"
					--without-omc
					--with-omlibrary=all
					$(use_enable omnotebook )
					$(use_enable omoptim )
					$(use_enable omshell )
	)

	if use corba ; then
		myeconfargs=( 	$myeconfargs
						--with-omniORB=/usr
						)
	fi

	if use boost ; then
		myeconfargs=( 	$myeconfargs
						--with-cppruntime
						)

	fi

	myeconfargs=( 	$myeconfargs
					CC=clang
					CXX=clang++
				)
	econf $myeconfargs
}

src_compile() {

	
	emake $MAKEOPTS omc omc-diff omplot omlibrary-all ReferenceFiles CC=clang CXX=clang++
	if use omnotebook ; then
		emake $MAKEOPTS omnotebook
	fi
	if use omshell ; then
		emake $MAKEOPTS omshell
	fi
	if use omoptim ; then
		emake $MAKEOPTS omoptim
	fi
}

src_install() {

	emake DESTDIR="${D}" install

}
