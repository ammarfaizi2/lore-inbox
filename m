Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbVAHNpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbVAHNpQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 08:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbVAHNpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 08:45:16 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:40390 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S261167AbVAHNpI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 08:45:08 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Announce: ksymoops 2.4.11 is available
Date: Sun, 09 Jan 2005 00:45:04 +1100
Message-ID: <31721.1105191904@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/ksymoops/v2.4

ksymoops-2.4.11.tar.gz           Source tarball, includes RPM spec file
ksymoops-2.4.11-1.src.rpm        As above, in SRPM format
ksymoops-2.4.11-1.i386.rpm       Compiled with gcc 3.4.2, glibc 2.3.3
patch-ksymoops-2.4.11.gz         Patch from ksymoops 2.4.10 to 2.4.11.

Changelog extract

        * Tweak nm command when target is NULL.  Marty Leisner.


Some people have reported problems building ksymoops, with unresolved
references in libbfd (htab_create, htab_find_slot_with_hash).  Try
http://www.cs.helsinki.fi/linux/linux-kernel/2002-13/0196.html first,
if that does not work, contact the binutils maintainers.  This is not a
ksymoops problem, ksymoops only uses libbfd.  Any unresolved references
from libbfd are a binutils problem.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQFB3+Pgi4UHNye0ZOoRAhgEAJ4u87+sCotHwtizKGxnlgV/LrJAOgCdESIO
D8bwKhY/1Aw8u//HJ6wqBog=
=SSlO
-----END PGP SIGNATURE-----

