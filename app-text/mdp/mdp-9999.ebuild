# Copyright 2019 Heinrich Kruger
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic

if [[ "${PV}" == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/visit1985/mdp.git"
else
	SRC_URI="https://github.com/visit1985/mdp/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="A command-line based markdown presentation tool."
HOMEPAGE="https://github.com/visit1985/mdp"

LICENSE="GPL-3"
SLOT="0"

DEPEND="sys-libs/ncurses:0"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}/${PN}-libs.patch"
)

src_configure() {
	append-cflags $(pkg-config --cflags ncursesw)
	append-libs $(pkg-config --libs ncursesw)
}

src_install() {
	emake PREFIX="/usr" DESTDIR="${D}" install
}
