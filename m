Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130352AbRAAHJC>; Mon, 1 Jan 2001 02:09:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130389AbRAAHIw>; Mon, 1 Jan 2001 02:08:52 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:1555 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S130352AbRAAHIj>;
	Mon, 1 Jan 2001 02:08:39 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Announce: modutils 2.3.24 is available 
Date: Mon, 01 Jan 2001 17:38:06 +1100
Message-ID: <6246.978331086@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/modutils/v2.3

patch-modutils-2.3.24.gz        Patch from modutils 2.3.23 to 2.3.24
modutils-2.3.24.tar.gz          Source tarball, includes RPM spec file
modutils-2.3.24-1.src.rpm       As above, in SRPM format
modutils-2.3.24-1.i386.rpm      Compiled with egcs-2.91.66, glibc 2.1.2
modutils-2.3.24-1.sparc.rpm     Compiled for combined sparc 32/64
patch-2.4.0-prerelease.gz	Adds persistent data and generic string
				support to kernel 2.4.0-prerelease.

Changelog extract

	* Correct check for empty generic string.
	* Add alias usbdevfs usbcore.

Assuming no problems are found in modutils and assuming that kernel
2.4.0-prerelease is followed by the official 2.4 kernel then this
version of modutils will be repackaged as modutils 2.4.0.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.3 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE6UCXNi4UHNye0ZOoRAhaJAKCzYo7GnRf8gr9xFLIiQINO64idjgCeISBw
kH56mNikV9R9ExZvE6e56Zk=
=riJL
-----END PGP SIGNATURE-----

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
