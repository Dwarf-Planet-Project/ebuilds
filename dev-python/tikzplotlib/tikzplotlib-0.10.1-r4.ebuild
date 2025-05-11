# Copyright 2019-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{9..13} )

inherit distutils-r1 virtualx

DESCRIPTION="Convert matplotlib figures into TikZ/PGFPlots"
HOMEPAGE="
	https://github.com/texworld/tikzplotlib/
	https://pypi.org/project/tikzplotlib/
"
SRC_URI="https://github.com/JasonGross/${PN}/archive/refs/tags/v${PV}.post13.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# https://github.com/texworld/tikzplotlib/issues/567 for mpl-3.6.0 dep
RDEPEND="
	app-text/texlive[extra]
	dev-python/matplotlib[latex,${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/webcolors[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/pandas[${PYTHON_USEDEP}]
		dev-python/pytest-codeblocks[${PYTHON_USEDEP}]
		dev-python/scipy[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx doc dev-python/mock

src_unpack() {
    unpack ${P}.gh.tar.gz
    mv ${WORKDIR}/${P}.post13 ${WORKDIR}/${P}
}

src_test() {
	local -x MPLBACKEND=Agg
	virtx distutils-r1_src_test
}

python_test() {
	epytest || die "Tests failed with ${EPYTHON}"
}
