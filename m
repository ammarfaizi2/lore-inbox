Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314085AbSGUMtH>; Sun, 21 Jul 2002 08:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314451AbSGUMtH>; Sun, 21 Jul 2002 08:49:07 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:40455 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S314085AbSGUMtG>;
	Sun, 21 Jul 2002 08:49:06 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Announce: ksymoops 2.4.6 is available 
Date: Sun, 21 Jul 2002 22:51:44 +1000
Message-ID: <21426.1027255904@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/ksymoops/v2.4

ksymoops-2.4.6.tar.gz		Source tarball, includes RPM spec file
ksymoops-2.4.6-1.src.rpm	As above, in SRPM format
ksymoops-2.4.6-1.i386.rpm	Compiled with 2.96 20000731, glibc 2.2.2
patch-ksymoops-2.4.6.gz		Patch from ksymoops 2.4.5 to 2.4.6.

Changelog extract

	* m68k call trace does not have trailing ' '.  Reported by
	  Richard Zidlicky.
	* MIPS has a hole in the register dump, skip $26 and $27 (k0, k1).
	  Maciej W. Rozycki.
	* Only print decoded registers if they resolve to kernel symbols.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE9Oq5ei4UHNye0ZOoRAhqWAKDANeYZmpoFTCCkSay0J145efDMdwCeO1ZV
J5yrpbjdSqFv3vOtRyb1Euo=
=EzNN
-----END PGP SIGNATURE-----

