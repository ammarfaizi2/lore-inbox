Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315536AbSGaLFl>; Wed, 31 Jul 2002 07:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315544AbSGaLFl>; Wed, 31 Jul 2002 07:05:41 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:19206 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S315536AbSGaLFl>;
	Wed, 31 Jul 2002 07:05:41 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Announce: modutils 2.4.19 is available 
Date: Wed, 31 Jul 2002 21:01:28 +1000
Message-ID: <11589.1028113288@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/modutils/v2.4

modutils-2.4.19.tar.gz          Source tarball, includes RPM spec file
modutils-2.4.19-1.src.rpm       As above, in SRPM format
modutils-2.4.19-1.i386.rpm      Compiled with gcc 2.96 20000731,
                                glibc 2.2.2.
modutils-2.4.19-1.ia64.rpm	Compiled with gcc 2.96-ia64-20000731,
				glibc-2.2.3.
patch-modutils-2.4.19.gz        Patch from modutils 2.4.18 to 2.4.19.

Changelog extract

	* Correct ia64 SEGREL relocations.  Fixes incorrect unwind data for
	  ia64 modules.
	* Remove 64 bit warnings.
	* New aliases.  Bill Nottingham.
	* Add R_PARISC_PCREL22F.  Richard Hirst.
	* Remove flex warning.

IA64 users who debug modules are strongly urged to upgrade to this release.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE9R8OHi4UHNye0ZOoRAv1JAKC3ksQihlgdBi3JVUMVLuEmey4xYQCgn0Au
I2Kr/TXXXuxEevqJnW/GF6s=
=Xs2g
-----END PGP SIGNATURE-----

