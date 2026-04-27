# Maintainers: Mike Cooper <mythmon at elem.us>, Mikko <mikko at 5x.fi>

_pkgname=terraria
pkgname="${_pkgname}-server"
pkgver=1.4.5.6
_pkgver=$(echo $pkgver | sed 's/\.//g')
pkgrel=49
pkgdesc="Official dedicated server for Terraria"
arch=('x86_64')
license=('unknown')
url="https://terraria.org/"
makedepends=('unzip')
source=("https://terraria.org/api/download/pc-dedicated-server/${pkgname}-${_pkgver}.zip"
        'config.txt'
        "${pkgname}@.service"
        "${_pkgname}.tmpfiles"
        "${_pkgname}.sysusers")
sha256sums=('d75c455ac217fd3434448c8f8251c1347f0875a85c438589dc71b557777e9155'
            '6a87f9f758811528913fa4828667b200ab7dcb6623734475ecbd8f8dab337b2f'
            'b2cfeb15b6e5bf97d1b7a0b0bdbec9289a842d37c52414c5b57aadda66b1b6a6'
            '31d745af54f2e57b6be32a95e869d9e29f83126d85dec3bab47f1bd0b5542e84'
            'edd3b435307c816e9454662d44e872626ab2dfe908f42a7f4529b63e4ac67d0f')

package() {
    install -d "${pkgdir}/opt"
    cp -ar "${srcdir}/${_pkgver}/Linux" "${pkgdir}/opt/${pkgname}"
    chmod +x "${pkgdir}/opt/${pkgname}"/TerrariaServer*
    install config.txt "${pkgdir}/opt/${pkgname}/config.txt.example"

    install -d "${pkgdir}/usr/bin"
    ln -s "/opt/${pkgname}/TerrariaServer.bin.x86_64" "${pkgdir}/usr/bin/terraria-server"

    install -Dm644 "${srcdir}/${_pkgname}.sysusers" "$pkgdir/usr/lib/sysusers.d/${_pkgname}.conf"
    install -Dm644 "${srcdir}/${_pkgname}.tmpfiles" "$pkgdir/usr/lib/tmpfiles.d/${_pkgname}.conf"
    install -Dm644 "${srcdir}/${pkgname}@.service" "${pkgdir}/usr/lib/systemd/system/${pkgname}@.service"
}
