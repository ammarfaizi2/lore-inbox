Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261794AbUCGJLZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 04:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbUCGJLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 04:11:25 -0500
Received: from pr-117-210.ains.net.au ([202.147.117.210]:61125 "EHLO
	mail.ocs.com.au") by vger.kernel.org with ESMTP id S261794AbUCGJLT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 04:11:19 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Announce: modutils 2.4.27 is available
Date: Sun, 07 Mar 2004 20:10:35 +1100
Message-ID: <22158.1078650635@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/modutils/v2.4

modutils-2.4.27.tar.gz          Source tarball, includes RPM spec file
modutils-2.4.27-1.src.rpm       As above, in SRPM format
modutils-2.4.27-1.i386.rpm	Compiled with gcc 3.2.2 20030222,
				glibc 2.3.2.
modutils-2.4.27-1.ia64.rpm	Compiled with gcc 2.96-ia64-20000731,
				glibc 2.2.3.
patch-modutils-2.4.27.gz        Patch from modutils 2.4.26 to 2.4.27.

Changelog extract

	* Ambiguous or invalid backslash in insmod.8.  Eric S. Raymond.
	* Move alias loop check higher up.  Sergey Vlasov.
	* Correct alias for pg, it is a char, not block device.  Sergey Vlasov.
	* obj-arm plt/got bugfix.  Thomas Fleischmann.
	* Only default to combined i386 if the user has x86_64 ELF headers.
	* Update INSTALL and README.
	* Reorder configure.in to move tests that require gcc to after gcc is
	  defined.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQFASucKi4UHNye0ZOoRAgELAJ4qMVrl7byAMImEp2OdJcVFhiv/SgCeOT4Y
+/1XmO9t2ZIbUJsGzshGsNE=
=vIbI
-----END PGP SIGNATURE-----

