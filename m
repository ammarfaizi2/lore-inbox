Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262415AbSKYEcg>; Sun, 24 Nov 2002 23:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262416AbSKYEcg>; Sun, 24 Nov 2002 23:32:36 -0500
Received: from rj.SGI.COM ([192.82.208.96]:43164 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S262415AbSKYEcf>;
	Sun, 24 Nov 2002 23:32:35 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Announce: modutils 2.4.22 is available
Date: Mon, 25 Nov 2002 15:39:38 +1100
Message-ID: <6714.1038199178@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/modutils/v2.4

modutils-2.4.22.tar.gz          Source tarball, includes RPM spec file
modutils-2.4.22-1.src.rpm       As above, in SRPM format
modutils-2.4.22-1.i386.rpm      Compiled with gcc 2.96 20000731,
                                glibc 2.2.2.
modutils-2.4.22-1.ia64.rpm	Compiled with gcc 2.96-ia64-20000731,
				glibc-2.2.3.
modutils-2.4.22-1.sparc.rpm	Compiled for combined 32/64 sparc, with gcc
				2.95.4, glibc-2.2.5.
patch-modutils-2.4.22.gz        Patch from modutils 2.4.21 to 2.4.22.

Changelog extract

	* Avoid unaligned traps on alpha.  Ivan Kokshaysky.
	* Handle R_PPC64_NONE relocs, remove warnings.  Alan Modra.
	* Add DESTDIR to build (from SuSe).
	* Check for special characters in module name (from SuSe).
	* Check x86_64 for -mcmodel=kernel (from SuSe).
	* Add alias for osst (from SuSe).
	* Check for illegal mixture of gcc 2 and 3 (from RedHat).
	* Build libmodutils.a (from RedHat).
	* Selectively add aliases, above, below, prune entries (from Mandrake).
	* Add MODUTILS_MACROS (from Mandrake).
	* Remove more warnings.
	* Add Kerntypes to prune list.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE94amIi4UHNye0ZOoRAm03AJ0ZSirkpfWwpNO0bQnfs9kn2osEIgCcCh4w
sT7Y8Qc4EE7/cXAf9ult4VE=
=kpEp
-----END PGP SIGNATURE-----

