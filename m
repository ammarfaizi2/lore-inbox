Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280969AbRKKF4G>; Sun, 11 Nov 2001 00:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280970AbRKKFz4>; Sun, 11 Nov 2001 00:55:56 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:29197 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S280969AbRKKFzj>;
	Sun, 11 Nov 2001 00:55:39 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Announce: modutils 2.4.11 is available 
Date: Sun, 11 Nov 2001 16:55:29 +1100
Message-ID: <26919.1005458129@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/modutils/v2.4

modutils-2.4.11.tar.gz          Source tarball, includes RPM spec file
modutils-2.4.11-1.src.rpm       As above, in SRPM format
modutils-2.4.11-1.i386.rpm      Compiled with gcc 2.96 20000731,
				glibc 2.2.2.
patch-modutils-2.4.11.gz        Patch from modutils 2.4.10 to 2.4.11.

Related kernel patches.

patch-2.4.2-persistent.gz       Adds persistent data and generic string
				support to kernel 2.4.2 onwards.  Optional.

Changelog extract

	* Add taint printing to lsmod.
	* PPC64 support.  Alan Modra, Anton Blanchard.  Tweaked by Keith Owens.
	* HPPA64 configure fix.  Reported by Helge Deller, different fix by
	  Keith Owens.
	* PNPBIOS support.  Andrey Panin.
	* Add __sparc_dot_ to depmod.  Alex Buell.
	* Add generic __dot_ support to depmod.  Keith Owens.

Sparc and ia64 rpms to follow later.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE77hLQi4UHNye0ZOoRAjK3AKCmLVgxU1NIU+diZ1eOhy0XYj3LaACdG+zl
s+An31n7UFc6wSKpmUPf710=
=4M20
-----END PGP SIGNATURE-----

