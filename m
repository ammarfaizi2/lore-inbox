Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271950AbRH2L7k>; Wed, 29 Aug 2001 07:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271949AbRH2L7a>; Wed, 29 Aug 2001 07:59:30 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:35090 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S271948AbRH2L7Z>;
	Wed, 29 Aug 2001 07:59:25 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Announce: modutils 2.4.8 is available 
Date: Wed, 29 Aug 2001 21:59:30 +1000
Message-ID: <25643.999086370@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/modutils/v2.4

modutils-2.4.8.tar.gz           Source tarball, includes RPM spec file
modutils-2.4.8-1.src.rpm        As above, in SRPM format
modutils-2.4.8-1.i386.rpm       Compiled with egcs-2.91.66, glibc 2.1.2
modutils-2.4.8-1.ia64.rpm       Compiled with gcc 2.96-ia64-000717 snap 001117,
				libc-2.2.1.
modutils-2.4.8-1.sparc.rpm      Compiled for combined 32/64 sparc.
patch-modutils-2.4.8.gz         Patch from modutils 2.4.7 to 2.4.8.

Related kernel patches.

patch-2.4.2-persistent.gz       Adds persistent data and generic string
				support to kernel 2.4.2 onwards.  Optional.

Changelog extract

	* Always define flag_unresolved_error.  Debian #108934.
	* Check for symindx out of bounds.  H. J. Lu.
	* Archdata for MIPS, dbe table.  Maciej W. Rozycki.
	* Archdata for PPC, ftr fixup.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.3 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE7jNkhi4UHNye0ZOoRAvvKAKCD5OUnQxNOAHrz1jBzeS/zO2Hw+wCgvXLj
c3+Y2N0lw9filBkXNA8BBLg=
=JDR4
-----END PGP SIGNATURE-----

