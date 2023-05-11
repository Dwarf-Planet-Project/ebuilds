# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python2_7 pypy python3_10 python3_11)

inherit distutils-r1

DESCRIPTION="Python tool for extracting information from PDF documents"
HOMEPAGE="http://www.unixuser.org/~euske/python/pdfminer/ https://pypi.org/project/pdfminer/"
SRC_URI="mirror://pypi/p/pdfminer.six/pdfminer.six-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc examples"
DEPEND="!app-text/pdfminer"

src_unpack(){
	unpack pdfminer.six-${PV}.tar.gz
	mv pdfminer.six-${PV} pdfminer_six-${PV}
}

python_compile_all(){
	use examples && emake -C samples all
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/. )
	use examples && local EXAMPLES=( samples/. )
	distutils-r1_python_install_all
}
