# Maintainers: Mike Cooper <mythmon at elem.us>, Mikko <mikko at 5x.fi>

_pkgname=terraria
pkgname="${_pkgname}-server"
pkgver=1.4.5.8
_pkgver=$(echo $pkgver | sed 's/\.//g')
pkgrel=49
pkgdesc="Official dedicated server for Terraria"
arch=('x86_64')
license=('unknown')
url="https://terraria.org/"
depends=('tmux')
makedepends=('unzip')
source=("https://terraria.org/api/download/pc-dedicated-server/${pkgname}-${_pkgver}.zip"
        "${pkgname}.sh"
        'config.txt'
        "${pkgname}@.service"
        "${_pkgname}.tmpfiles"
        "${_pkgname}.sysusers")
sha256sums=('f513a4ac9789d34af766291ae217c9cd7d9472e13782a0e2b17512f70d7a8334'
            '12ff6682a62c1c60881820fcda140e6bed470956cbe3470d181334d693cbf055'
            '6a87f9f758811528913fa4828667b200ab7dcb6623734475ecbd8f8dab337b2f'
            '0d7b715b8f12253ddfb5483a95dc491466960120737a06a5903b3613b1767090'
            '31d745af54f2e57b6be32a95e869d9e29f83126d85dec3bab47f1bd0b5542e84'
            'edd3b435307c816e9454662d44e872626ab2dfe908f42a7f4529b63e4ac67d0f')

backup=("etc/conf.d/${pkgname}/default.txt")

package() {
    install -d "${pkgdir}/opt"
    cp -ar "${_pkgver}/Linux" "${pkgdir}/opt/${pkgname}"
    chmod +x "${pkgdir}/opt/${pkgname}"/TerrariaServer*

    install -Dm644 "config.txt" "${pkgdir}/etc/conf.d/${pkgname}/default.txt"
    install -Dm755 "${pkgname}.sh" "${pkgdir}/usr/bin/${pkgname}"
    install -Dm644 "${_pkgname}.sysusers" "${pkgdir}/usr/lib/sysusers.d/${_pkgname}.conf"
    install -Dm644 "${_pkgname}.tmpfiles" "${pkgdir}/usr/lib/tmpfiles.d/${_pkgname}.conf"
    install -Dm644 "${pkgname}@.service" "${pkgdir}/usr/lib/systemd/system/${pkgname}@.service"
}
