# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit subversion

DESCRIPTION="Relational Meta Language and the Meta Modelica Compiler"
HOMEPAGE="http://www.ida.liu.se/labs/pelab/rml/"
SRC_URI=""

LICENSE="OSMC"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=" dev-lang/smlnj "
RDEPEND="${DEPEND}"

CHOST=x86_64-linux-gcc

ESVN_REPO_URI="https://openmodelica.org/svn/MetaModelica/trunk"

src_unpack() {
    subversion_src_unpack
}

src_configure() {

    
	econf  

}

src_compile() {

	emake 

}

src_install() {

	emake install " --prefix=/${D}"

}


