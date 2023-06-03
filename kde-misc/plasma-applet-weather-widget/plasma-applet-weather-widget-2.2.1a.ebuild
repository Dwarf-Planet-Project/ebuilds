# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ ${PV} = *9999* ]] ; then
	EGIT_REPO_URI="https://github.com/blackadderkate/weather-widget-2.git"
	inherit git-r3
else
	SRC_URI="https://github.com/blackadderkate/weather-widget-2/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64"
fi

DESCRIPTION="Plasma 5 applet for weather forecasts"
HOMEPAGE="https://store.kde.org/p/998917/
https://github.com/blackadderkate/weather-widget-2"

LICENSE="GPL-2+"
SLOT="5"
IUSE=""

DEPEND="
	>=dev-qt/qtxmlpatterns-5.12.1-r1:5[qml(+)]
	>=kde-frameworks/plasma-5.60.0:5
"
RDEPEND="${DEPEND}"

DOCS=( README.md )

src_unpack(){
    default
    mv ${WORKDIR}/weather-widget-2-${PV} ${WORKDIR}/plasma-applet-weather-widget-${PV}
}
