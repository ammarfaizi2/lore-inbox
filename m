Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281139AbRKTPxz>; Tue, 20 Nov 2001 10:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281140AbRKTPxp>; Tue, 20 Nov 2001 10:53:45 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:11277 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S281139AbRKTPxf>;
	Tue, 20 Nov 2001 10:53:35 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: kbuild-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Announce: Kernel Build for 2.5, Release 1.8 is available
Date: Wed, 21 Nov 2001 02:53:22 +1100
Message-ID: <29459.1006271602@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

Release 1.8 of kernel build for kernel 2.5 (kbuild 2.5) has been
released.  http://sourceforge.net/projects/kbuild/, Package kbuild-2.5,
download release 1.8.

kbuild 2.5 currently supports i386, ia64, sparc32.  Sparc builds but
has not been booted, YMMV.

http://marc.theaimsgroup.com/?l=linux-kernel&m=99725412902968&w=2
contains information about the base release.

Changelog:

  New macro uses_asm_offsets().

  Handle versions of md5sum that do not treat '-' as 'read from stdin'.

  Change the assembler default from -traditional to -no-traditional.

  Remove -no-traditional kludge from pp_makefile2.

  Fix cross compile bugs.

  Remove kernel include list from host[ca]flags.

  Move some ia64 entries into the common patch.

  Replace ifnsel(config)/objlink() with objlink(!config).

  Correct errors in sbus Makefile.in.

  Add sparc32 support.

  This release does not support CML2, only use it with CML1.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE7+nxwi4UHNye0ZOoRArsiAKCS82U7xyVzyYtwg6j3JB1oUkhrrgCgy4ns
XGq+pyY9wUdDPylHNkJiZTw=
=m34u
-----END PGP SIGNATURE-----

