# As it can not overwrite the version in the layer meta-fsl-arm, we have to use
#   another file extension for new patch to the append in the meta-fsl-arm

# Append path for freescale layer to include alsa-state asound.conf
FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_mx6 = " \
	file://asound.state.wm89586062 \
"

SRC_URI_append_mx6ul = " \
        file://asound.state \
        file://alsa-state \
"

do_install_append_mx6() {
    install -m 0644 ${WORKDIR}/asound.state.wm89586062 ${D}${localstatedir}/lib/alsa/asound.state
}

inherit update-rc.d

INITSCRIPT_NAME = "alsa-state"
INITSCRIPT_PARAMS = "start 99 2 3 4 5 . stop 30 0 6 ."

do_install_append_mx6ul() {
    install -m 0644 ${WORKDIR}/asound.state ${D}${localstatedir}/lib/alsa/asound.state

# reinstall alsa-state script
	install -d ${D}${sysconfdir}/init.d
	install -m 0755 ${WORKDIR}/alsa-state ${D}${sysconfdir}/init.d/alsa-state
}

# for i.MX7D
PACKAGE_ARCH_mx7 = "${MACHINE_ARCH}"
