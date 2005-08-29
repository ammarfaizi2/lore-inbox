Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751225AbVH2CMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbVH2CMs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 22:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbVH2CMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 22:12:47 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:5537 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751219AbVH2CMr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 22:12:47 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: kdb@oss.sgi.com
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Announce: kdb v4.4 is available for kernel 2.6.13
Date: Mon, 29 Aug 2005 12:12:34 +1000
Message-ID: <4699.1125281554@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

KDB (Linux Kernel Debugger) has been updated.

ftp://oss.sgi.com/projects/kdb/download/v4.4/
ftp://ftp.ocs.com.au/pub/mirrors/oss.sgi.com/projects/kdb/download/v4.4/

Note:  Due to a spam attack, the kdb@oss.sgi.com mailing list is now
subscriber only.  If you reply to this mail, you may wish to trim
kdb@oss.sgi.com from the cc: list.

Current versions are :-

  kdb-v4.4-2.6.13-common-1.bz2
  kdb-v4.4-2.6.13-i386-1.bz2
  kdb-v4.4-2.6.13-ia64-1.bz2
  kdb-v4.4-2.6.11-x86-64-2.bz2 (may or may not work with 2.6.13).


Changelog extract since kdb-v4.4-2.6.12-common-1.

2005-08-29 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.13-common-1.

2005-08-24 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.13-rc7-common-1.

2005-08-08 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.13-rc6-common-1.

2005-08-02 Keith Owens  <kaos@sgi.com>

	* Print more fields from filp, dentry.
	* Add kdb=on-nokey to suppress kdb entry from the keyboard.
	* kdb v4.4-2.6.13-rc5-common-1.

2005-07-30 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.13-rc4-common-1.

2005-07-26 Keith Owens  <kaos@sgi.com>

	* Fix compile problem with CONFIG_USB_KBD.
	* kdb v4.4-2.6.13-rc3-common-3.

2005-07-22 Keith Owens  <kaos@sgi.com>

	* The asmlinkage kdb() patch was lost during packaging.  Reinstate it.
	* kdb v4.4-2.6.13-rc3-common-2.

2005-07-19 Keith Owens  <kaos@sgi.com>

	* Add support for USB keyboard (OHCI only).  Aaron Young, SGI.
	* kdb v4.4-2.6.13-rc3-common-1.

2005-07-08 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.13-rc2-common-1.

2005-07-01 Keith Owens  <kaos@sgi.com>

	* Make kdb() asmlinkage to avoid problems with CONFIG_REGPARM.
	* Change some uses of smp_processor_id() to be preempt safe.
	* Use DEFINE_SPINLOCK().
	* kdb v4.4-2.6.13-rc1-common-1.


Changelog extract since kdb-v4.4-2.6.12-i386-1.

2005-08-29 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.13-i386-1.

2005-08-24 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.13-rc7-i386-1.

2005-08-08 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.13-rc6-i386-1.

2005-08-02 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.13-rc5-i386-1.

2005-07-30 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.13-rc4-i386-1.

2005-07-22 Keith Owens  <kaos@sgi.com>

	* Compile fix for kprobes.
	* kdb v4.4-2.6.13-rc3-i386-2.

2005-07-19 Keith Owens  <kaos@sgi.com>

	* Add support for USB keyboard (OHCI only).  Aaron Young, SGI.
	* kdb v4.4-2.6.13-rc3-i386-1.

2005-07-08 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.13-rc2-i386-1.

2005-07-01 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.13-rc1-i386-1.

2005-06-19 Keith Owens  <kaos@sgi.com>

	* gcc 4 compile fix, remove extern kdb_hardbreaks.  Steve Lord.
	* kdb v4.4-2.6.12-i386-2.


Changelog extract since kdb v4.4-2.6.12-ia64-1.

2005-08-29 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.13-ia64-1.

2005-08-24 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.13-rc7-ia64-1.

2005-08-08 Keith Owens  <kaos@sgi.com>

	* Add minstate command.
	* kdb v4.4-2.6.13-rc6-ia64-1.

2005-08-02 Keith Owens  <kaos@sgi.com>

	* Replace hard coded kdb declarations with #include <asm/sections>.
	* kdb v4.4-2.6.13-rc5-ia64-1.

2005-07-30 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.13-rc4-ia64-1.

2005-07-22 Keith Owens  <kaos@sgi.com>

	* Handle INIT delivered while in physical mode.
	* kdb v4.4-2.6.13-rc3-ia64-2.

2005-07-19 Keith Owens  <kaos@sgi.com>

	* Add support for USB keyboard (OHCI only).  Aaron Young, SGI.
	* kdb v4.4-2.6.13-rc3-ia64-1.

2005-07-08 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.13-rc2-ia64-1.

2005-07-01 Keith Owens  <kaos@sgi.com>

	* kdb v4.4-2.6.13-rc1-ia64-1.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQFDEm8Si4UHNye0ZOoRAuu5AKCFIqHBB2+F9ttZlbKs4nObW+88oQCfT4IE
jA9tECuXxeB+Rwd7Giqkj4k=
=SnMr
-----END PGP SIGNATURE-----

