Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130389AbRAAHKc>; Mon, 1 Jan 2001 02:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131572AbRAAHKW>; Mon, 1 Jan 2001 02:10:22 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:2835 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S130389AbRAAHKG>;
	Mon, 1 Jan 2001 02:10:06 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Announce: ksymoops 2.3.6 is available
Date: Mon, 01 Jan 2001 17:39:34 +1100
Message-ID: <6312.978331174@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

Mirror at ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/ksymoops/v2.3

ksymoops-2.3.6.tar.gz		Source tarball, includes RPM spec file
ksymoops-2.3.6-1.src.rpm	As above, in SRPM format
ksymoops-2.3.6-1.i386.rpm	Compiled with egcs-2.91.66, glibc 2.1.2

Changelog extract

	* Add INSTALL_MANDIR to Makefile and spec.
	* Extra IA64 lines.
	* Alpha changed 'Trace: '  to 'Trace:'.
	* Add note about using bfd from non-standard location.

Assuming no problems are found in ksymoops and assuming that kernel
2.4.0-prerelease is followed by the official 2.4 kernel then this
version of ksymoops will be repackaged as ksymoops 2.4.0.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.3 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE6UCYmi4UHNye0ZOoRAqP5AJ9t3P6HyjYn8y9wjGeV53XnN4qRsgCgtMom
iy9dXWmVqhxQSMFzTNGDMZw=
=ZYco
-----END PGP SIGNATURE-----

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
