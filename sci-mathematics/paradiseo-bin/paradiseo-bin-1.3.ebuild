# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit unpacker

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

	mkdir paradiseo-${PV}
	cd paradiseo-${PV}
	wget -O paradiseo-${PV}.deb "http://build.openmodelica.org/apt/pool/contrib-wheezy/${PN}_${PV}-beta2-3_${ARCH}.deb" || die
	unpack_deb  ./paradiseo-${PV}.deb

}

src_install() {

	dodir /usr/lib/paradiseo
	insinto /usr/lib/paradiseo
	dolib.a usr/lib/paradiseo/libcma.a      
	dolib.a usr/lib/paradiseo/libeo.a
	dolib.a usr/lib/paradiseo/libeomoo.a
	dolib.a usr/lib/paradiseo/libeoutils.a
	dolib.a usr/lib/paradiseo/libes.a
	dolib.a usr/lib/paradiseo/libga.a
	dolib.a usr/lib/paradiseo/libmoeo.a 
	dodir /usr/include/paradiseo/
	cd usr/include/paradiseo/
	cp -r ./*  ../../../../../image/usr/include/paradiseo/
}
