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
}

