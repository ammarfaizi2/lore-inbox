Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271951AbRH2MEk>; Wed, 29 Aug 2001 08:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271949AbRH2MEa>; Wed, 29 Aug 2001 08:04:30 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:37138 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S271951AbRH2MES>;
	Wed, 29 Aug 2001 08:04:18 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Announce: ksymoops 2.4.2 is available
Date: Wed, 29 Aug 2001 22:04:30 +1000
Message-ID: <25675.999086670@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/ksymoops/v2.4

ksymoops-2.4.2.tar.gz		Source tarball, includes RPM spec file
ksymoops-2.4.2-1.src.rpm	As above, in SRPM format
ksymoops-2.4.2-1.i386.rpm	Compiled with egcs-2.91.66, glibc 2.1.2
ksymoops-2.4.2-1.ia64.rpm	Compiled with gcc 2.96-ia64-000717 snap
				001117, libc-2.2.1.
patch-ksymoops-2.4.2.gz		Patch from ksymoops 2.4.1 to 2.4.2.

No sparc binary, I do not have access to a sparc system with a decent
version of binutils.

Changelog extract

	* Add STATIC and DYNAMIC variables to Makefile for build flexibility.
	  Maciej W. Rozycki.
	* Handle multiple call traces from sysrq-t.
	* Cris support.  Hans-Peter Nilsson.
	* Regname cleanup.
	* Fix incorrect adjustment for bss variables.
	* Add --ignore-insmod-path (-i) and --ignore-insmod-all (-I) flags,
	  mainly for initrd filenames.
	* Add --truncate (-T) flag for mixed 32/64 bit symbol sources.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.3 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE7jNpNi4UHNye0ZOoRAj+gAJ9avY/AFsMVOU1i7A1MiRRcmq+MZACePTvO
5Hi4wYE60HZuL+h/VjmjggE=
=wESA
-----END PGP SIGNATURE-----

