# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

DESCRIPTION="Solr is a popular open source enterprise search platform built on Apache Lucene"
HOMEPAGE="http://lucene.apache.org/solr/"
SRC_URI="mirror://apache/lucene/${PN}/${PV}/${P}-src.tgz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="idea netbeans"

RDEPEND="netbeans? ( dev-util/netbeans:= )
		idea? ( dev-util/idea-ultimate )"
DEPEND="${RDEPEND}
		virtual/jdk:1.7
		dev-java/ant-ivy:2
		dev-java/ant-core
		dev-java/icedtea:8"
