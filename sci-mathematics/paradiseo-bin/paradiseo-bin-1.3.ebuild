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

src_unpack() {

	mkdir ${PN}-${PV}
	cd ${PN}-${PV}
	#echo $PN
	localbuild=${PN%-bin}
	#echo $localbuild
	wget -O paradiseo-${PV}.deb "http://build.openmodelica.org/apt/pool/contrib-wheezy/${localbuild}_${PV}-beta2-3_${ARCH}.deb" || die
	unpack_deb  ./paradiseo-${PV}.deb

}

src_install() {

	dodir /usr/lib/paradiseo
	cd usr/lib/paradiseo
	cp -r ./* ../../../../../image/usr/lib/paradiseo/
	cd ../../..
	dodir /usr/include/paradiseo/
	cd usr/include/paradiseo/
	cp -r ./*  ../../../../../image/usr/include/paradiseo/
}
