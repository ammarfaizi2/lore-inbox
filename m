Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266344AbUFQBRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266344AbUFQBRL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 21:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266342AbUFQBRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 21:17:11 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:22010 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266333AbUFQBRA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 21:17:00 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: kdb@oss.sgi.com
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Announce: kdb v4.4 is available for kernel 2.6.7 
Date: Thu, 17 Jun 2004 11:16:55 +1000
Message-ID: <3469.1087435015@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

KDB (Linux Kernel Debugger) has been updated.

ftp://oss.sgi.com/projects/kdb/download/v4.4/

Current versions are :-

  kdb-v4.4-2.6.7-common-1.bz2
  kdb-v4.4-2.6.7-i386-1.bz2
  kdb-v4.4-2.6.7-ia64-1.bz2

Changelog extract since kdb-v4.4-2.6.7-rc2-common-1.

2004-06-16 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.7-common-1.

2004-06-09 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.7-rc3-common-1.

2004-06-09 Keith Owens  <kaos@sgi.com>

	* Namespace clean up.  Mark code/variables as static when it is only
	  used in one file, delete dead code/variables.
	* Saved interrupt state requires long, not int.
	* kdb v4.4-2.6.7-rc2-common-3.

2004-06-08 Keith Owens  <kaos@sgi.com>

	* Whitespace clean up, no code changes.
	* kdb v4.4-2.6.7-rc2-common-2.



Changelog extract since kdb-v4.4-2.6.7-rc2-i386-1.

2004-06-16 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.7-i386-1.

2004-06-10 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.7-rc3-i386-1.

2004-06-09 Keith Owens  <kaos@sgi.com>

	* Namespace clean up.  Mark code/variables as static when it is only
	  used in one file, delete dead code/variables.
	* kdb v4.4-2.6.7-rc2-i386-3.

2004-06-08 Keith Owens  <kaos@sgi.com>

	* Whitespace clean up, no code changes.
	* kdb v4.4-2.6.7-rc2-i386-2.



Changelog extract since kdb v4.4-2.6.7-rc2-ia64-1.

2004-06-16 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.7-ia64-1.

2004-06-10 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.7-rc3-ia64-1.

2004-06-09 Keith Owens  <kaos@sgi.com>

	* Namespace clean up.  Mark code/variables as static when it is only
	  used in one file, delete dead code/variables.
	* Saved interrupt state requires long, not int.
	* kdb v4.4-2.6.7-rc2-ia64-3.

2004-06-08 Keith Owens  <kaos@sgi.com>

	* Whitespace clean up, no code changes.
	* kdb v4.4-2.6.7-rc2-2.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQFA0PEHi4UHNye0ZOoRAlkUAJ451FJCUeyPbtwB+o86LoxRjlg82QCfb219
eCxmRqs/pT69UudnvN/2pVA=
=NJMr
-----END PGP SIGNATURE-----

