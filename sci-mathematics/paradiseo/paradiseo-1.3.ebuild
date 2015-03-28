# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="A Software Framework for Metaheuristics"
HOMEPAGE="http://paradiseo.gforge.inria.fr"
SRC_URI="https://gforge.inria.fr/frs/download.php/27238/paradiseo-${PV}-beta2.tar.gz"

LICENSE="CeCILL-2"
SLOT="0"
KEYWORDS="amd64"
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
	unpack paradiseo-${PV}-beta2.tar.gz
	mv paradiseo-${PV}-beta2 paradiseo-${PV} 
}

src_install() {

	cd paradiseo-${PV}
	./installParadiseo.sh --prefix=/usr --skipdart < 1

}
