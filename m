Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287045AbSB0AmB>; Tue, 26 Feb 2002 19:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290593AbSB0Alv>; Tue, 26 Feb 2002 19:41:51 -0500
Received: from rj.SGI.COM ([204.94.215.100]:52709 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S287045AbSB0All>;
	Tue, 26 Feb 2002 19:41:41 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Announce: modutils 2.4.14 is available 
Date: Wed, 27 Feb 2002 11:41:32 +1100
Message-ID: <2034.1014770492@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/modutils/v2.4

modutils-2.4.14.tar.gz          Source tarball, includes RPM spec file
modutils-2.4.14-1.src.rpm       As above, in SRPM format
modutils-2.4.14-1.i386.rpm      Compiled with gcc 2.96 20000731,
                                glibc 2.2.2.
modutils-2.4.14-1.ia64.rpm      Compiled with gcc 2.96-ia64-20000731,
                                glibc-2.2.3.
modutils-2.4.14-1.sparc.rpm     Compiled for combined 32/64 sparc, with
                                gcc 2.95.4, glibc-2.2.5.
patch-modutils-2.4.14.gz        Patch from modutils 2.4.13 to 2.4.14.

Changelog extract

        * Clean up modinfo, modprobe, rmmod, lsmod man pages.  Barry Rountree.
        * Add EXPORT_SYMBOL_GPL to genksyms list.  Arjan van de Ven.
        * Document %{kernel_version} and %{using_checksums} for modinfo.
          Pavel Roskin.
        * Remove RCS Id lines.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE8fCs7i4UHNye0ZOoRAhhMAJ9OYeSk49HvZ6I/Z24Mw6qEeYtXlgCeJThn
Jr0F97xpQ3YdbYBKF0lktZA=
=Y9gW
-----END PGP SIGNATURE-----

