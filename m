Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130902AbRCQBtl>; Fri, 16 Mar 2001 20:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131063AbRCQBtb>; Fri, 16 Mar 2001 20:49:31 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:26628 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S130902AbRCQBtM>;
	Fri, 16 Mar 2001 20:49:12 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Announce: ksymoops 2.4.1 is available
Date: Sat, 17 Mar 2001 12:48:17 +1100
Message-ID: <15797.984793697@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

Mirror at ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/ksymoops/v2.4

ksymoops-2.4.1.tar.gz		Source tarball, includes RPM spec file
ksymoops-2.4.1-1.src.rpm	As above, in SRPM format
ksymoops-2.4.1-1.i386.rpm	Compiled with egcs-2.91.66, glibc 2.1.2
ksymoops-2.4.1-1.sparc.rpm	Compiled as 32 bit user space, it
				supports 64 bit kernels.
ksymoops-2.4.1-1.ia64.rpm	Compiled with gcc 2.96-ia64-000717 snap
				001117, libc-2.2.1.

Changelog extract

	* Accept any 'Bad ' text in EIP.
	* Add long option names.
	* Recent modutils has support for ksymoops, update ksymoops man page.
	* White space clean up.
	* Remove deprecated gcc extensions.

This time I remembered to bump the version number ;).

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.3 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE6ssJgi4UHNye0ZOoRAhlHAJ9LcNSy4n1uyj6fvyUmRHhBnNSlLgCgyxCU
cHq6zvGs2KE86uJ6rydW0DI=
=JVZt
-----END PGP SIGNATURE-----

