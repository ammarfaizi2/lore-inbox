Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281225AbRKUDBm>; Tue, 20 Nov 2001 22:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281159AbRKUDBW>; Tue, 20 Nov 2001 22:01:22 -0500
Received: from zok.SGI.COM ([204.94.215.101]:54916 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S281559AbRKUDBU>;
	Tue, 20 Nov 2001 22:01:20 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Announce: modutils 2.4.12 is available 
Date: Wed, 21 Nov 2001 14:01:07 +1100
Message-ID: <2462.1006311667@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/modutils/v2.4

modutils-2.4.12.tar.gz          Source tarball, includes RPM spec file
modutils-2.4.12-1.src.rpm       As above, in SRPM format
modutils-2.4.12-1.i386.rpm      Compiled with gcc 2.96 20000731,
				glibc 2.2.2.
modutils-2.4.12-1.ia64.rpm      Compiled with gcc 2.96-ia64-20000731,
				glibc-2.2.3.
modutils-2.4.12-1.sparc.rpm     Compiled for combined 32/64 sparc, with
				gcc 2.95.4 20011006, glibc-2.2.4.
patch-modutils-2.4.12.gz        Patch from modutils 2.4.11 to 2.4.12.

Related kernel patches.

patch-2.4.2-persistent.gz       Adds persistent data and generic string
				support to kernel 2.4.2 onwards.  Optional.

Changelog extract

	* More verbose hints for unresolved symbols in non-GPL modules.
	* Remove spurious #endif from elf_ppc64.h.
	* Use #define for taint flags, add taint flag for non-SMP capable cpus.
	* Do not check if the module is already loaded when -n is specified.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE7+xjwi4UHNye0ZOoRAqvkAKDe5XiHMIWB7Ypud6mh+ApWnedG5ACfbMTt
xgCkQJg+tcc7wWKdvPXBwSY=
=SZvQ
-----END PGP SIGNATURE-----

