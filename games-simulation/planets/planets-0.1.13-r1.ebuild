# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils games

DESCRIPTION="a simple interactive planetary system simulator"
HOMEPAGE="http://planets.homedns.org/"
SRC_URI="http://planets.homedns.org/dist/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

RDEPEND="
	dev-lang/tcl:0=
	dev-lang/tk:0="
DEPEND="${RDEPEND}
	dev-lang/ocaml
	dev-ml/labltk
	dev-ml/camlp4"

src_prepare() {
	epatch "${FILESDIR}"/ocaml4_typing
}

src_install() {
	dogamesbin planets
	doicon ${PN}.png
	domenu ${PN}.desktop
	doman ${PN}.1
	dohtml getting_started.html
	dodoc CHANGES CREDITS KEYBINDINGS.txt README TODO
	prepgamesdirs
}
