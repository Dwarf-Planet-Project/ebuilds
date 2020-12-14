# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="Pidgin/Purple PRotocol PLugin for Discord"
HOMEPAGE="https://github.com/EionRobb/purple-discord"
EGIT_REPO_URI="${HOMEPAGE}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-im/pidgin
dev-vcs/git
dev-libs/json-glib"
RDEPEND="${DEPEND}"

src_prepare() {
eapply_user
	default
	sed -i "s,convert, TMPDIR='${TEMP}' convert -define registry:temporary-path='${TEMP}',g" Makefile
	#sed -i "s,convert,rsvg-convert,g" Makefile
	#sed -i "s,none discord-alt-logo.svg,none MVG:discord-alt-logo.svg,g" Makefile
	#sed -i "s,resize,size,g" Makefile
	#sed -i "133s/install-icons//" Makefile
	#sed -i "150d" Makefile
	#sed -i "150d" Makefile
	#sed -i "150d" Makefile
	#sed -i "147d" Makefile
	#sed -i "147d" Makefile
	#sed -i "147d" Makefile
	#sed -i "147i\\\techo  \$\(DISCORD_ICONS_DEST\)" Makefile
	#sed -i "147i\\\techo  \$\(DIRPERM\)" Makefile
}

pkg_postinst() {
	if use X; then
		if [[ -d "${ROOT}"usr/share/fonts/misc ]] ; then
			einfo ">>> Running mkfontdir on ${ROOT}usr/share/fonts/misc"
			mkfontdir "${ROOT}"usr/share/fonts/misc
		fi
		font_pkg_postinst
	fi
}
