#Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="an extensible Modelica-based open source platform for optimization, simulation and analysis of complex dynamic systems"
HOMEPAGE="jmodelica.org"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="superlu ipopt eclipse cppad sundials"

DEPEND="superlu? ( sci-libs/superlu )
        ipopt? ( sci-libs/ipopt )
		eclipse? ( dev-util/eclipse-sdk-bin  )
	cppad? ( sci-libs/coinor-cppad )
	dev-python/cython
	dev-vcs/subversion
	dev-python/ipython
	dev-util/cmake
	dev-lang/swig:0
	dev-java/ant-core
	dev-python/numpy
	sci-libs/scipy
	dev-python/matplotlib
	dev-python/lxml
	dev-python/nose
	"
RDEPEND="${DEPEND}"

inherit subversion 

ESVN_REPO_URI="https://svn.jmodelica.org/tags/${PV}"


src_unpack() {
	subversion_src_unpack
}

src_configure() {
	myopts=""

	if (use ipopt) then
		myopts+="$(use_with ipopt)=/usr "
	fi

    if (use superlu) then
		myopts+="$(use_with superlu) "
    fi

	if (use eclipse) then
		myopts+="$(use_with eclipse)=/usr/bin "
	fi
	
	if (use cppad) then
		myopts+="$(use_with cppad)=/usr/include "
	fi

	if (use !sundials) then
		myopts+="$(use_with sundials) "
	fi
	
	myopts+="--prefix=${D}"

	econf $myopts
}

src_compile() {
	emake #DESTDIR="${D}"
}
