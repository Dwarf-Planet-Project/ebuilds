# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2 qmake-utils qt4-r2 flag-o-matic

DESCRIPTION="The Space Design Tool"
HOMEPAGE="https://sdt.dwarfplanetproject.de.vu"
SRC_URI=""

LICENSE="EUPL"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=" dev-qt/qtsvg
         dev-qt/qtxmlpatterns
		 dev-qt/qtopengl
		 dev-qt/qtgui
		 dev-qt/qtcore
		 dev-qt/qt3support
		 sci-libs/blas-reference
		 dev-qt/designer
		 sci-libs/gsl
		 sci-visualization/qtiplot
		 "

RDEPEND="${DEPEND}" 

EGIT_REPO_URI="https://github.com/Dwarf-Planet-Project/SpaceDesignTool.git"

SRC_URI=""

EGIT_BRANCH="master"

src_unpack() {
	git-2_src_unpack
	append-flags -Wno-error
}

src_configure() {
	#cd thirdparty/qtiplot/
	#eqmake4 qtiplot.pro
	#cd 3rdparty/qwt
	#eqmake4 qwt.pro
	#cd ../qwtplot3d/
	#eqmake4 qwtplot3d.pro
	#cd ../../../../
	#pwd
	append-flags -Wno-error
	eqmake4 STA.pro -recursive 
}

src_compile() {
#cd thirdparty/qtiplot/
#emake
#cd 3rdparty/qwt/
#emake
#cd ../qwtplot3d/
#emake
#cd ../../../../
emake

}
