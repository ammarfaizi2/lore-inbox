Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310259AbSCACLF>; Thu, 28 Feb 2002 21:11:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310320AbSCACJQ>; Thu, 28 Feb 2002 21:09:16 -0500
Received: from rj.SGI.COM ([204.94.215.100]:50561 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S310304AbSCACIT>;
	Thu, 28 Feb 2002 21:08:19 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Announce: ksymoops 2.4.4 is available
Date: Fri, 01 Mar 2002 13:08:10 +1100
Message-ID: <26621.1014948490@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/ksymoops/v2.4

ksymoops-2.4.4.tar.gz		Source tarball, includes RPM spec file
ksymoops-2.4.4-1.src.rpm	As above, in SRPM format
ksymoops-2.4.4-1.i386.rpm	Compiled with 2.96 20000731, glibc 2.2.2
patch-ksymoops-2.4.4.gz		Patch from ksymoops 2.4.3 to 2.4.4.

Changelog extract

	* Defeat stupid gcc warning about ignored trigraphs.
	* Fix truncate mask.  Hugh Dickens.
	* Ignore syslog-ng prefix.
	* Handle GPLONLY prefix in ksyms.
	* Differentiate between i370/cris and arm register lines.
	* Handle arm lr (last return).
	* Handle alpha ra (return address).

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE8fuKJi4UHNye0ZOoRAhw6AJ9b9veEwO90sguw9BSejyFaI5+fpACgo+Nl
7KYtKoOgJ+5WEnilpffz2Yk=
=Wxy3
-----END PGP SIGNATURE-----

