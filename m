Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262412AbTJ3MgM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 07:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbTJ3MgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 07:36:12 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:56585 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id S262412AbTJ3MgJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 07:36:09 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Announce: modutils 2.4.26 is available
Date: Thu, 30 Oct 2003 23:35:34 +1100
Message-ID: <5608.1067517334@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/modutils/v2.4

modutils-2.4.26.tar.gz          Source tarball, includes RPM spec file
modutils-2.4.26-1.src.rpm       As above, in SRPM format
modutils-2.4.26-1.i386.rpm      Compiled with gcc 2.96 20000731,
                                glibc 2.2.2.
modutils-2.4.26-1.ia64.rpm	Compiled with gcc 2.96-ia64-20000731,
				glibc-2.2.3.
patch-modutils-2.4.26.gz        Patch from modutils 2.4.25 to 2.4.26.

Changelog extract

	* Ignore SHT_MIPS_DWARF sections.  Alvaro Martinez Echevarria.
	* Add -malign-double to cflags for 64 bit builds.
	* Fix zlib linking problems.  Maciej W. Rozycki.
	* Remove hard coded limits on length of modules.conf lines.
	* Alias updates.  Red Hat.
	* Makefile fix for parallel build using bison.  Andreas Haumer.
	* Document difference between patterns and modules in modprobe.
	  Frank Murphy.
	* Suppress module not found message on modprobe -q.  Frank Murphy.
	* Add module name to some messages.  Red Hat.
	* Add amd64 support.  i386 now defaults to combined 32/64 bit.
	  Arnd Bergmann.
	* Older glibc versions had a wrong name for R_390_GOTOFF32.
	  Arnd Bergmann.
	* Run known directories in the correct historical order.  Red Hat.
	* Upgrade config.sub, config.guess to glibc 2.3.2.
	* Add sh64 support.  Benedict Gaster.
	* Only build sys_oim.o when COMPAT_2_0 is set, it breaks with ia64 and
	  recent glibc.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE/oQWWi4UHNye0ZOoRAlDuAKCOxVla9fBCgjRe+hPuEMAnovkRdgCfW2QM
VFTy2ByssHs8KpTUC+cKASA=
=9yWv
-----END PGP SIGNATURE-----

