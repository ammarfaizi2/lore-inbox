Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130142AbRBZEod>; Sun, 25 Feb 2001 23:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130143AbRBZEoY>; Sun, 25 Feb 2001 23:44:24 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:7027 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S130142AbRBZEoM>;
	Sun, 25 Feb 2001 23:44:12 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Announce: modutils 2.4.3 is available 
Date: Mon, 26 Feb 2001 15:44:05 +1100
Message-ID: <18253.983162645@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

Just a small collection of bug fixes.  No new facilities.

ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/modutils/v2.4

modutils-2.4.3.tar.gz           Source tarball, includes RPM spec file
modutils-2.4.3-1.src.rpm        As above, in SRPM format
modutils-2.4.3-1.i386.rpm       Compiled with egcs-2.91.66, glibc 2.1.2
modutils-2.4.3-1.sparc64.rpm    Combined sparc 32/64.
modutils-2.4.3-1.ia64.rpm       Compiled with gcc 2.96-ia64-000717 snap 001117,
				libc-2.2.1.
patch-modutils-2.4.3.gz         Patch from modutils 2.4.2 to 2.4.3.

Related kernel patches.

patch-2.4.2-persistent.gz       Adds persistent data and generic string
				support to kernel 2.4.2.  Optional.

Changelog extract

	* putenv() strings must be copied first.
	* Not everybody has Elf64_Xword.
	* Add stdlib.h to some files for glibc 2.2.
	* Redhat modutils-2.4.0-alias.patch.
	* Out by one error in alloca.  Spotted by Yann Droneaud.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.3 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE6md8Vi4UHNye0ZOoRAre4AJ9DqRQamIQnyrC/SogQtnEOdYmAsgCffV8a
ga0aQX649OmmvwYAdXA/l0c=
=4sk2
-----END PGP SIGNATURE-----

