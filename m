Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312271AbSCRJzc>; Mon, 18 Mar 2002 04:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312272AbSCRJzX>; Mon, 18 Mar 2002 04:55:23 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:64780 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S312271AbSCRJzI>;
	Mon, 18 Mar 2002 04:55:08 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Announce: ksymoops 2.4.5 is available 
Date: Mon, 18 Mar 2002 20:54:56 +1100
Message-ID: <4887.1016445296@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/ksymoops/v2.4

ksymoops-2.4.5.tar.gz		Source tarball, includes RPM spec file
ksymoops-2.4.5-1.src.rpm	As above, in SRPM format
ksymoops-2.4.5-1.i386.rpm	Compiled with 2.96 20000731, glibc 2.2.2
patch-ksymoops-2.4.5.gz		Patch from ksymoops 2.4.4 to 2.4.5.

Changelog extract

	* Add x86-64 support.  Andi Kleen.
	* Clean up and generalize register dumps.
	* Print blank lines between each major block of output for readability.

Previous versions of ksymoops picked up and decoded some registers but
not all.  2.4.5 picks up almost all registers and attempts to decode
values >= 1024.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE8lblvi4UHNye0ZOoRAmiHAJ4/h0SXuHvnB2ToXevNJ3jKwTW9EACgiu5D
48pj+AQjyrZ6jmUYbaJNLFU=
=3u4P
-----END PGP SIGNATURE-----

