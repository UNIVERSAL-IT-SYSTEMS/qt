# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit qt4-build-edge

DESCRIPTION="The Qt3 support module for the Qt toolkit."
LICENSE="|| ( GPL-3 GPL-2 )"
SLOT="4"
KEYWORDS=""
IUSE="+accessibility phonon"

DEPEND="~x11-libs/qt-core-${PV}[qt3support,qt-copy=]
	~x11-libs/qt-gui-${PV}[qt3support,accessibility=,qt-copy=]
	~x11-libs/qt-sql-${PV}[qt3support,qt-copy=]
	"
RDEPEND="${DEPEND}"
PDEPEND="phonon? ( || ( ~x11-libs/qt-phonon-${PV}[qt-copy=] media-sound/phonon ) )"

QT4_TARGET_DIRECTORIES="
src/qt3support
src/tools/uic3
tools/designer/src/plugins/widgets
tools/qtconfig
tools/porting"
QT4_EXTRACT_DIRECTORIES="${QT4_TARGET_DIRECTORIES}"


src_configure() {
	myconf="${myconf} -qt3support
		$(qt_use phonon gstreamer)
		$(qt_use phonon)
		$(qt_use accessibility)"
	qt4-build-edge_src_configure
}
