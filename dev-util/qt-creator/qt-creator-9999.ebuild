# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit qt4-edge multilib git

DESCRIPTION="Lightweight IDE for C++ development centering around Qt"
HOMEPAGE="http://labs.qtsoftware.com/page/Projects/Tools/QtCreator"

EGIT_REPO_URI="git://labs.trolltech.com/qt-creator/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="debug doc"

DEPEND=">=x11-libs/qt-assistant-4.5.0_rc1
	>=x11-libs/qt-core-4.5.0_rc1
	>=x11-libs/qt-dbus-4.5.0_rc1
	>=x11-libs/qt-gui-4.5.0_rc1
	>=x11-libs/qt-qt3support-4.5.0_rc1
	>=x11-libs/qt-script-4.5.0_rc1
	>=x11-libs/qt-sql-4.5.0_rc1
	>=x11-libs/qt-svg-4.5.0_rc1
	>=x11-libs/qt-test-4.5.0_rc1
	>=x11-libs/qt-webkit-4.5.0_rc1"

RDEPEND="${DEPEND}
	|| ( media-sound/phonon >=x11-libs/qt-phonon-4.5.0_rc1 )"

PATCHES=(
	"${FILESDIR}/docs_gen.patch"
)

src_prepare() {
	# bug #261448
	for target in src/qworkbench.pri src/qworkbenchlibrary.pri src/qworkbenchplugin.pri;do
		einfo "Fixing ${target}"
		sed -i "s/lib\/qtcreator/$(get_libdir)\/qtcreator/" \
			${target} || die "seding ${target} failed"
	done
	qt4-edge_src_prepare
}

src_configure() {
	eqmake4 qtcreator.pro || die "eqmake4 failed"
}

src_install() {
	emake INSTALL_ROOT="${D}/usr" install || die "emake install failed"
	if use doc;then
		insinto /usr/share/doc/qtcreator/
		doins "${S}"/share/doc/qtcreator/qtcreator.qch || die "Installing documentation failed"
		doins -r "${S}"/doc/html || die "Installing html documentation  failed"
	fi
	make_desktop_entry qtcreator QtCreator qtcreator_logo_48 \
		'Qt;Development;IDE' || die "make_desktop_entry failed"
}
