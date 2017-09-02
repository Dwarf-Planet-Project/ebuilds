# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit eutils versionator multilib toolchain-funcs multiprocessing

MY_PN="OpenFOAM"
MY_PV=$(get_version_component_range 1-2)
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Open Field Operation and Manipulation - CFD Simulation Toolbox"
HOMEPAGE="http://www.openfoam.org"
SRC_URI="http://dl.openfoam.org/source/4-1 -> ${P}.tar.gz
		http://dl.openfoam.org/third-party/4-1 -> ${P}-thirdparty.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples opendx src paraview"

RDEPEND="!=sci-libs/openfoam-bin-${MY_PV}*
	!=sci-libs/openfoam-kernel-${MY_PV}*
	!=sci-libs/openfoam-meta-${MY_PV}*
	!=sci-libs/openfoam-solvers-${MY_PV}*
	!=sci-libs/openfoam-utilities-${MY_PV}*
	!=sci-libs/openfoam-wmake-${MY_PV}*
	sci-mathematics/cgal
	sci-libs/parmetis
	sci-libs/parmgridgen
	sci-libs/scotch
	virtual/mpi
	opendx? ( sci-visualization/opendx )
	paraview? ( sci-visualization/paraview[development] )
	sys-cluster/openmpi
	sci-libs/vtk"

DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen[dot] )"

S=${WORKDIR}/${MY_P}
INSDIR="/usr/$(get_libdir)/${MY_PN}/${MY_P}"

pkg_setup() {
	# just to be sure the right profile is selected (gcc-config)
	if ! version_is_at_least 4.3 $(gcc-version) ; then
		die "${PN} requires >=sys-devel/gcc-4.3 to compile."
	fi

	elog
	elog "In order to use ${MY_PN} you should add the following line to ~/.bashrc :"
	elog
	elog "alias startOF$(delete_all_version_separators ${MY_PV})='source ${INSDIR}/etc/bashrc'"
	elog
	elog "And everytime you want to use OpenFOAM you have to execute startOF$(delete_all_version_separators ${MY_PV})"
	ewarn
}

src_unpack() {
	unpack ${A}
	mv "${WORKDIR}/ThirdParty-$(get_major_version ${PV}).x-version-${PV}" "${WORKDIR}/ThirdParty-${PV}"
	mv "${WORKDIR}/OpenFOAM-$(get_major_version ${PV}).x-version-${PV}" "${WORKDIR}/OpenFOAM-${PV}"
}

src_configure() {
	export WM_MPLIB=OPENMPI

	sed -i -e "s|WM_MPLIB:=OPENMPI|WM_MPLIB:="${WM_MPLIB}"|" etc/bashrc
	sed -i -e "s|setenv WM_MPLIB OPENMPI|setenv WM_MPLIB "${WM_MPLIB}"|" etc/cshrc

	sed -i 's#cd ${BASH_SOURCE%/\*/\*/\*} \&\&##' etc/bashrc
	#sed -i -e "s|^set foamInstall = \$HOME|set foamInstall = /usr/$(get_libdir)|" etc/cshrc

	sed -i 's#export WM_PROJECT_DIR=$WM_PROJECT_INST_DIR/$WM_PROJECT-$WM_PROJECT_VERSION#export WM_PROJECT_DIR=$WM_PROJECT_INST_DIR#' etc/bashrc
	chmod +x etc/config.sh/functions

	sed -i -e 's|^export ParaView_DIR=$WM_THIRD_PARTY_DIR/platforms/$WM_ARCH$WM_COMPILER/$paraviewArchName|export ParaView_DIR=/usr|' etc/config.sh/paraview
	sed -i -e 's|^setenv ParaView_DIR $WM_THIRD_PARTY_DIR/platforms/$WM_ARCH$WM_COMPILER/$paraviewArchName|setenv ParaView_DIR /usr|' etc/config.csh/paraview
}

src_compile() {
	export WM_NCOMPPROCS=$(makeopts_jobs)

	export FOAM_INST_DIR=${WORKDIR}
	source etc/bashrc

	find wmake -name dirToString -exec rm -rf {} +
	find wmake -name wmkdep -exec rm -rf {}+

	./Allwmake || die "could not build"
	if use doc ; then
		doc/Allwmake || die "could not build"
	fi
}

# Doesn't do anything sane
#src_test() {
#	cd bin
#	./foamInstallationTest
#}

src_install() {
	insinto ${INSDIR}
	doins -r etc

	use examples && doins -r tutorials

	use src && doins -r src

	insopts -m0755
	doins -r bin applications platforms wmake

	dodoc README.html doc/Guides-a4/*.pdf

	if use doc ; then
		dohtml -r doc/Doxygen
	fi
}
