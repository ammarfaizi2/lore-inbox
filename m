Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311558AbSCXFPM>; Sun, 24 Mar 2002 00:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311564AbSCXFPB>; Sun, 24 Mar 2002 00:15:01 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:42258 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S311558AbSCXFO6>;
	Sun, 24 Mar 2002 00:14:58 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Announce: modutils 2.4.15 is available 
Date: Sun, 24 Mar 2002 16:14:24 +1100
Message-ID: <24219.1016946864@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/modutils/v2.4

modutils-2.4.15.tar.gz          Source tarball, includes RPM spec file
modutils-2.4.15-1.src.rpm       As above, in SRPM format
modutils-2.4.15-1.i386.rpm      Compiled with gcc 2.96 20000731,
                                glibc 2.2.2.
patch-modutils-2.4.15.gz        Patch from modutils 2.4.13 to 2.4.15.

Changelog extract

	* Expand small snprintf buffers to PATH_MAX.  Debian #138350.
	* Add alias ppp-compress-18 ppp_mppe.  Frank Cusack.
	* Add x86-64 support.  Andreas Jaeger, Andi Kleen.
	* Clean up and document modinfo printing of parameters.  Miloslav Trmac.
	* Update config.{guess,sub} to 2002-03-04.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE8nWCvi4UHNye0ZOoRAnnZAKDw1Syiw1VzCtwGQvhWQv3y+hgvfACfU573
Rltj2HYXvLHUtKvr1qGHick=
=sH6A
-----END PGP SIGNATURE-----

