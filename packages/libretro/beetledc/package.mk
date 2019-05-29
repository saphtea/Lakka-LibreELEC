################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
#
#  This Program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#
#  This Program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.tv; see the file COPYING.  If not, write to
#  the Free Software Foundation, 51 Franklin Street, Suite 500, Boston, MA 02110, USA.
#  http://www.gnu.org/copyleft/gpl.html
################################################################################

PKG_NAME="beetledc"
PKG_VERSION="2af59a8"
PKG_REV="1"
PKG_ARCH="arm i386 x86_64 aarch64"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/beetle-dc"
PKG_GIT_URL="$PKG_SITE"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_SHORTDESC="Beetle DC (formerly Reicast) is a multiplatform Sega Dreamcast emulator"
PKG_LONGDESC="Beetle DC (formerly Reicast) is a multiplatform Sega Dreamcast emulator"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  if [ "$ARCH" == "arm" ]; then
    if [ "$PROJECT" == "Switch" ]; then
      make platform=armv-neon HAVE_OPENMP=0 FORCE_GLES=0 GLES=0 HAVE_OIT=1
    else
        if [ "$OPENGLES_SUPPORT" = "yes" ]; then
          REICAST_GLES=1
        else
          REICAST_GLES=0
        fi
        make platform=rpi FORCE_GLES=$REICAST_GLES HAVE_OPENMP=0
    fi
  elif [ "$ARCH" == "aarch64" ]; then
    make platform=arm64 HAVE_OPENMP=0 FORCE_GLES=0 GLES=0 HAVE_OIT=1
  else
    make platform=unix unix AS=${AS} CC_AS=${AS} ARCH=${ARCH} HAVE_OPENMP=0
  fi
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp beetledc_libretro.so $INSTALL/usr/lib/libretro/
}