Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271568AbRHPM2h>; Thu, 16 Aug 2001 08:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271570AbRHPM2U>; Thu, 16 Aug 2001 08:28:20 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:35598 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S271568AbRHPM2L>;
	Thu, 16 Aug 2001 08:28:11 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Announce: modutils 2.4.7 is available 
Date: Thu, 16 Aug 2001 22:28:19 +1000
Message-ID: <16639.997964899@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/modutils/v2.4

modutils-2.4.7.tar.gz           Source tarball, includes RPM spec file
modutils-2.4.7-1.src.rpm        As above, in SRPM format
modutils-2.4.7-1.i386.rpm       Compiled with egcs-2.91.66, glibc 2.1.2
patch-modutils-2.4.7.gz         Patch from modutils 2.4.6 to 2.4.7.

Sparc and IA64 versions to follow next week.

Related kernel patches.

patch-2.4.2-persistent.gz       Adds persistent data and generic string
				support to kernel 2.4.2 onwards.  Optional.

Changelog extract

	* Correct filename in depmod man page.  Debian #94652.
	* Note that modprobe requries a bare module name.
	* Ensure at least one space after section names in insmod map.
	* obj_kallsyms needs to be 32/64 safe.
	* Better error checking in makefiles.  Reported by Nico Schottelius.
	* S390 support from Ulrich Weigand.  Includes Debian #107308.
	* Add s390 iucv aliases.  Add binfmt-0000 off.  Fix modprobe man page
	  typo.  Redhat.
	* Non-zero return code for depmod with unresolved symbols.  Original by
	  Redhat, reworked by me.
	* Add alias tunl0 ipip, requested by Pekka Savola.
	* Aliases for parallel port devices.  Tim Waugh.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.3 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE7e7xji4UHNye0ZOoRArYxAKDXLc1zVThsZQbkHXfFDUTm7nML5QCeNYEY
7hc6U1q7AnCPMIk5VDSIrD8=
=1w56
-----END PGP SIGNATURE-----

