Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312560AbSFXMJq>; Mon, 24 Jun 2002 08:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312938AbSFXMJp>; Mon, 24 Jun 2002 08:09:45 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:53007 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S312560AbSFXMJo>;
	Mon, 24 Jun 2002 08:09:44 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: kbuild-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Announce: Kernel Build for 2.5, release 3.1 is available 
Date: Mon, 24 Jun 2002 22:09:35 +1000
Message-ID: <7587.1024920575@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

Release 3.1 of kernel build for kernel 2.5 (kbuild 2.5) is available.
http://sourceforge.net/projects/kbuild/, package kbuild-2.5, download
release 3.1.

New files:

kbuild-2.5-core-20
  Changes from core-19

  Add target 'install_with_errors'.
  Update documentation (Jak).
  Keep HOSTCC and HOSTLD in sync (reported by Jak).
  Sanitize filenames in shipped files.
  Bug fix in parser.
  Avoid spurious gcc 3.1 warnings (reported by Jak).

kbuild-2.5-common-2.5.24-1
kbuild-2.5-i386-2.5.24-1

  Upgrade to 2.5.24.
  Add target 'install_with_errors'.
  Correct install of vmlinux for debugging (Jak).

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE9Fwv9i4UHNye0ZOoRAvWQAKDj9Nr2mORorg4HPw2zw7d33OV6KgCgw/It
L4LHsijG9Q7FtqiBTWE6kOk=
=oi1u
-----END PGP SIGNATURE-----

