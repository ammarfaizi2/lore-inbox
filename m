Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264543AbTGGC7K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 22:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264582AbTGGC7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 22:59:10 -0400
Received: from zok.SGI.COM ([204.94.215.101]:38530 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S264543AbTGGC7I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 22:59:08 -0400
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: Announce: XFS split patches for 2.4.21
Date: Mon, 07 Jul 2003 13:13:23 +1000
Message-ID: <4186.1057547603@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

ftp://oss.sgi.com/projects/xfs/download/patches/2.4.21.  

For some time the XFS group have been producing split patches for XFS,
separating the core XFS changes from additional patches such as kdb,
xattr, acl, dmapi.  The split patches are released to the world with
the hope that developers and distributors will find them useful.

Read the README in each directory very carefully, the split patch
format has changed over a few kernel releases.  Any questions that are
covered by the README will be ignored.  There is even a 2.4.22/README
for the terminally impatient :).

Note: This is a respin as of 2.4.21-2003-07-07_02:01_UTC, it replaces
      the split patches that were done on 2003-06-23_01:45_UTC.  The
      latter patches contain bad XFS code and should not be used.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE/COVTi4UHNye0ZOoRAn92AJ90Ze81UyjrSk3APeM4Nc+d2r9a9QCdG1YF
iA8Gz8uofsei9oIsnmkwvMM=
=hjPi
-----END PGP SIGNATURE-----

