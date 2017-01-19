# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit java-pkg-2 java-ant-2

DESCRIPTION="Nutch is a well matured, production ready Web crawler."
HOMEPAGE="https://nutch.apache.org"
SRC_URI="mirror://apache/${PN:7}/${PV}/${P}-src.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
		virtual/jdk:=
		dev-java/ant-ivy:=
		dev-java/ant-core"
