Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318916AbSHMDAs>; Mon, 12 Aug 2002 23:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318917AbSHMDAs>; Mon, 12 Aug 2002 23:00:48 -0400
Received: from zok.SGI.COM ([204.94.215.101]:36506 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S318916AbSHMDAn>;
	Mon, 12 Aug 2002 23:00:43 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: linux-xfs@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: Announce: XFS split patches for 2.4.19 - respin
Date: Tue, 13 Aug 2002 13:04:25 +1000
Message-ID: <10392.1029207865@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

ftp://oss.sgi.com/projects/xfs/download/patches/2.4.19.

The xfs patches for 2.4.19 have been respun as of 2002-08-13 01:22 UTC.
This includes kdb v2.3 2.4.19 common-2, i386-3 plus some recent quota
and acl fixes.

For some time the XFS group have been producing split patches for XFS,
separating the core XFS changes from additional patches such as kdb,
xattr, acl, dmapi, kbuild 2.5.  These patches were initially intended
for internal use and for feeding to Linus but we got no response at
all.  The split patches are now being released to the world with the
hope that developers and distributors will find them useful.

Read the README in each directory very carefully, the split patch
format has changed over a few kernel releases.  Any questions that are
covered by the README will be ignored.  There is even a 2.4.20/README
for the terminally impatient :).

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE9WHc4i4UHNye0ZOoRApfUAJ9pHgjKao4t2659f5gQ932bfLJSpgCglw8r
ZJo02LJ3ceD5krbk9MOfc4k=
=EByk
-----END PGP SIGNATURE-----

