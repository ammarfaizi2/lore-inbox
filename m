Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313638AbSDZEmu>; Fri, 26 Apr 2002 00:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313645AbSDZEmt>; Fri, 26 Apr 2002 00:42:49 -0400
Received: from zok.SGI.COM ([204.94.215.101]:50836 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S313638AbSDZEmt>;
	Fri, 26 Apr 2002 00:42:49 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: kbuild-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Announce: Kernel Build for 2.5, Release 2.2 is available 
Date: Fri, 26 Apr 2002 14:42:28 +1000
Message-ID: <10571.1019796148@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

Release 2.2 of kernel build for kernel 2.5 (kbuild 2.5) is available.
http://sourceforge.net/projects/kbuild/, package kbuild-2.5, download
release 2.2.

   kbuild-2.5-core-7.bz2

   kbuild-2.5-common-2.4.18-6.bz2
   kbuild-2.5-i386-2.4.18-2.bz2
   kbuild-2.5-sparc64-2.4.18-2.bz2

   kbuild-2.5-common-2.5.10-1.bz2
   kbuild-2.5-i386-2.5.10-1.bz2

Changes from core-6 to core-7.

   Use cp -f/mv -f in case target files are marked read only.

   Fix bug where a key could be read from a record that had moved.

   Fix bug in handling of absolute link_subdirs().

   Unlink obsolete dependencies correctly.

   Reinstate checks for changed commands in user_command().

Changes from common-2.4.18-5 to common-2.4.18-6.

   Add tftpboot.img.

   Update 53c700 generated script.

   Add -traditional to scsi script pre-processing (unbalanced ' in comments).

Thanks to Tom Duffy for testing above and beyond the call of duty and
for the sparc64 patch.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE8yNqyi4UHNye0ZOoRAlZVAKC4kEnB/bYlOQrrjZsJFYQdTMKT0ACffoXB
x2BOQgfM1BPsWqqhZ980pfo=
=AIFS
-----END PGP SIGNATURE-----

