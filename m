Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272588AbRIUJLA>; Fri, 21 Sep 2001 05:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272620AbRIUJKu>; Fri, 21 Sep 2001 05:10:50 -0400
Received: from rj.sgi.com ([204.94.215.100]:4557 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S272588AbRIUJKo>;
	Fri, 21 Sep 2001 05:10:44 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Announce: ksymoops 2.4.3 is available
Date: Fri, 21 Sep 2001 19:09:58 +1000
Message-ID: <10723.1001063398@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/ksymoops/v2.4

ksymoops-2.4.3.tar.gz		Source tarball, includes RPM spec file
ksymoops-2.4.3-1.src.rpm	As above, in SRPM format
ksymoops-2.4.3-1.i386.rpm	Compiled with 2.96 20000731, glibc 2.2.2
ksymoops-2.4.3-1.ia64.rpm	Compiled with gcc 2.96-ia64-20000731,
				glibc-2.2.3.
patch-ksymoops-2.4.3.gz		Patch from ksymoops 2.4.2 to 2.4.3.

No sparc binary, I do not have access to a sparc system with a decent
version of binutils.

Changelog extract

	* Add Pid:.
	* Add -A "address list".  Idea pinched from Randy Dunlap's ksysmap.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE7qwPli4UHNye0ZOoRAqtjAJ9JKaMGxlU8Bwqwmn7ShJ9OhlctmgCg2rPQ
M4jW+vdQfuMSFPPRleKTj5Y=
=LC33
-----END PGP SIGNATURE-----

