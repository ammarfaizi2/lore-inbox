Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261626AbSI0EmJ>; Fri, 27 Sep 2002 00:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261627AbSI0EmJ>; Fri, 27 Sep 2002 00:42:09 -0400
Received: from zok.sgi.com ([204.94.215.101]:16047 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S261626AbSI0EmJ>;
	Fri, 27 Sep 2002 00:42:09 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: linux-xfs@sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: Announce: XFS split patches for 2.4.19 - respin 
In-Reply-To: Your message of "Tue, 13 Aug 2002 13:04:25 +1000."
             <10392.1029207865@kao2.melbourne.sgi.com> 
Date: Fri, 27 Sep 2002 14:45:58 +1000
Message-ID: <23406.1033101958@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

ftp://oss.sgi.com/projects/xfs/download/patches/2.4.19.

The xfs patches for 2.4.19 have been respun as of 2002-09-27 04:22 UTC.
This removes kbuild 2.5 support and includes several changes in the
xfs/kernel interface.

For some time the XFS group have been producing split patches for XFS,
separating the core XFS changes from additional patches such as kdb,
xattr, acl, dmapi.  The split patches are released to the world with
the hope that developers and distributors will find them useful.

Read the README in each directory very carefully, the split patch
format has changed over a few kernel releases.  Any questions that are
covered by the README will be ignored.  There is even a 2.4.20/README
for the terminally impatient :).

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE9k+KFi4UHNye0ZOoRAs+kAKDXP8nweVX+05BEMarcX71ZA2aT0wCeJmfZ
+dhYwnuFjukOmuWVyyZBzMM=
=HouQ
-----END PGP SIGNATURE-----

