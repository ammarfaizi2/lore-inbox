Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261502AbSJMMFM>; Sun, 13 Oct 2002 08:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261505AbSJMMFM>; Sun, 13 Oct 2002 08:05:12 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:47628 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S261502AbSJMMFM>;
	Sun, 13 Oct 2002 08:05:12 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Announce: modutils 2.4.21 is available
Date: Sun, 13 Oct 2002 22:10:41 +1000
Message-ID: <16837.1034511041@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/modutils/v2.4

modutils-2.4.21.tar.gz          Source tarball, includes RPM spec file
modutils-2.4.21-1.src.rpm       As above, in SRPM format
modutils-2.4.21-1.i386.rpm      Compiled with gcc 2.96 20000731,
                                glibc 2.2.2.
modutils-2.4.21-1.ia64.rpm	Compiled with gcc 2.96-ia64-20000731,
				glibc-2.2.3.
modutils-2.4.21-1.sparc.rpm	Compiled for combined 32/64 sparc, with gcc
				2.95.4, glibc-2.2.5.
patch-modutils-2.4.21.gz        Patch from modutils 2.4.20 to 2.4.21.

Changelog extract

	* Add ksymoops support for sbss section.
	* Allow include to handle multiple files, with globbing.  Kelledin.

If you are seeing ksymoops warnings about symbols in the sbss section
(objdump -t /lib/modules/.../foo.o | grep sbss to identify symbols in
sbss) then you should upgrade to modutils 2.4.21 and ksymoops 2.4.7.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE9qWK/i4UHNye0ZOoRAuDKAJ0VKV0NnT2c95aljISrL2Xbdv4VVACfcbBK
bCGc8Dc/sxZhVAgZEgZ2Xoc=
=8vCW
-----END PGP SIGNATURE-----

