# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit cmake-utils

DESCRIPTION="A Software Framework for Metaheuristics"
HOMEPAGE="http://paradiseo.gforge.inria.fr"
SRC_URI="https://gforge.inria.fr/frs/download.php/31732/ParadisEO-${PV}.tar.gz"

LICENSE="CeCILL-2"
SLOT="0"
KEYWORDS="~amd64"
#IUSE="examples coverage doc smp peo"

IUSE=""

DEPEND=""
REDEPEND="${DEPEND} make cmake"
#DEPEND="doc? ( app-doc/doxygen )
#	    coverage? ( dev-util/lcov )
#		smp? ( >=sys-devel/gcc-4.7.0 )
#		peo? ( dev-libs/libxml2 )"
#RDEPEND="${DEPEND}"

src_unpack() {
	unpack ParadisEO-${PV}.tar.gz
	mv ParadisEO-${PV} paradiseo-${PV}	
}

src_configure() {

	local mycmakeargs=(
	                	-DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release
	)

	cmake-utils_src_configure

}

src_compile() {
	${WORKDIR}/paradiseo-${PV}_build
	#cmake-utils_src_compile
}

src_install() {

	emake DESTDIR="${D}" install

}
