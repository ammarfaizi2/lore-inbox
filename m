Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261440AbVCCDAE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbVCCDAE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 22:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbVCCC6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 21:58:04 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:29588 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261441AbVCCCyk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 21:54:40 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: kdb@oss.sgi.com
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Announce: kdb v4.4 is available for kernel 2.6.11 
Date: Thu, 03 Mar 2005 13:53:59 +1100
Message-ID: <9911.1109818439@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

KDB (Linux Kernel Debugger) has been updated.

ftp://oss.sgi.com/projects/kdb/download/v4.4/
ftp://ftp.ocs.com.au/pub/mirrors/oss.sgi.com/projects/kdb/download/v4.4/

Current versions are :-

  kdb-v4.4-2.6.11-common-1.bz2
  kdb-v4.4-2.6.11-i386-1.bz2
  kdb-v4.4-2.6.11-ia64-1.bz2
  kdb-v4.4-2.6.9-rc2-x86-64-1.bz2 (may or may not work with 2.6.11).


Changelog extract since kdb-v4.4-2.6.10-common-1.

2005-03-03 Keith Owens  <kaos@sgi.com>

	* Add kdb to drivers/serial/8250_early.c.  Francois Wellenreiter, Bull.
	* kdb v4.4-2.6.11-common-1.

2005-02-14 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.11-rc4-common-1.

2005-02-08 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.11-rc3-bk4-common-1.

2005-02-03 Keith Owens  <kaos@sgi.com>

	* Print more superblock fields.  Nathan Scott, SGI.
	* Remove kallsyms correction for modules, Linus took it.
	* kdb v4.4-2.6.11-rc3-common-1.

2005-01-27 Keith Owens  <kaos@sgi.com>

	* Add bio command.  Nathan Scott, SGI.
	* kdb v4.4-2.6.11-rc2-common-1.

2005-01-20 Keith Owens  <kaos@sgi.com>

	* Include kallsyms correction for modules until Linus takes it.
	* kdb v4.4-2.6.11-rc1-bk7-common-1.

2005-01-12 Keith Owens  <kaos@sgi.com>

	* kallsyms now supports all symbols properly, remove kdb patch.
	* Add last ditch allocator for debugging.
	* Update kdb_meminfo_read_proc() for vmalloc changes.
	* Update kdbm_vm.c for 4 level page tables.
	* kdb v4.4-2.6.11-rc1-common-1.


Changelog extract since kdb-v4.4-2.6.10-i386-1.

2005-03-03 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.11-i386-1.

2005-02-14 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.11-rc4-i386-1.

2005-02-08 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.11-rc3-bk4-i386-1.

2005-02-03 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.11-rc3-i386-1.

2005-01-27 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.11-rc2-i386-1.

2005-01-12 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.11-rc1-i386-1.


Changelog extract since kdb v4.4-2.6.10-ia64-1.

2005-03-03 Keith Owens  <kaos@sgi.com>

	* kdb-v4.4-2.6.11-ia64-1.

2005-02-14 Keith Owens  <kaos@sgi.com>

	* kdb-v4.4-2.6.11-rc4-ia64-1.

2005-02-08 Keith Owens  <kaos@sgi.com>

	* kdb-v4.4-2.6.11-rc3-bk4-ia64-1.

2005-02-03 Keith Owens  <kaos@sgi.com>

	* kdb-v4.4-2.6.11-rc3-ia64-1.

2005-01-27 Keith Owens  <kaos@sgi.com>

	* kdb-v4.4-2.6.11-rc2-ia64-1.

2005-01-20 Keith Owens  <kaos@sgi.com>

	* MCA and INIT stacks moved to per-cpu area.
	* kdb-v4.4-2.6.11-rc1-bk7-ia64-1.

2005-01-12 Keith Owens  <kaos@sgi.com>

	* ia64_spinlock_contention_pre3_4_end is in base kernel, remove from kdb.
	* Use last ditch allocator if unwind cannot allocate memory.
	* kdb-v4.4-2.6.11-rc1-ia64-1.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQFCJnxHi4UHNye0ZOoRAshTAKCusrSfgd19bwX9DaAD50qp1lhPhACgueil
PGciCp8r78zXcKJ+CkU2MBE=
=zbUH
-----END PGP SIGNATURE-----

