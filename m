Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279728AbRKHOet>; Thu, 8 Nov 2001 09:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279884AbRKHOei>; Thu, 8 Nov 2001 09:34:38 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:17679 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S279728AbRKHOeX>;
	Thu, 8 Nov 2001 09:34:23 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: kbuild-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Announce: Kernel Build for 2.5, Release 1.6 is available
Date: Fri, 09 Nov 2001 01:34:11 +1100
Message-ID: <21560.1005230051@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

"Release early, release often".

Release 1.6 of kernel build for kernel 2.5 (kbuild 2.5) has been
released.  http://sourceforge.net/projects/kbuild/, Package kbuild-2.5,
download release 1.6.

http://marc.theaimsgroup.com/?l=linux-kernel&m=99725412902968&w=2
contains information about the base release.

Changelog:

  Correct race condition on first build after renaming source
  or object trees.

  Support negated CONFIG options, this is easier to read
    select(CONFIG_QUOTA  dquot.o)
    select(!CONFIG_QUOTA noquot.o)

  This release does not support CML2, only use it with CML1.
  ESR is upgrading CML2 to kernel 2.4.14 first.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE76pfhi4UHNye0ZOoRAjj7AJsF/OYwIXj+fH+FNj5se0IOCWc7ZwCfQKef
j8zdyAzxnOTOjA/gGF42TOg=
=CHzL
-----END PGP SIGNATURE-----

