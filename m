Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265994AbUBQFN7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 00:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265995AbUBQFN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 00:13:59 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:42594 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S265994AbUBQFNz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 00:13:55 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: kdb@oss.sgi.com
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Announce: kdb v4.3 is available for kernel 2.6.3-rc4
Date: Tue, 17 Feb 2004 16:13:40 +1100
Message-ID: <7832.1076994820@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

ftp://oss.sgi.com/projects/kdb/download/v4.3/

Current versions are :-
  kdb-v4.3-2.6.3-rc4-common-1.bz2
  kdb-v4.3-2.6.3-rc3-i386-1.bz2
  kdb-v4.3-2.6.3-rc3-ia64-1.bz2

The arch specific i386 and ia64 patches have not changed between rc3
and rc4.  Use the arch rc3 patches with rc4-common-1.

Warning: the 2.6 versions of kdb have had minimal testing.  In
particular they have not been tested with CONFIG_PREEMPT.


Changelog extracts from 2.6.3-rc3.

common


2004-02-17 Keith Owens  <kaos@sgi.com>

	* Remove WAR for incorrect console registration patch.
	* kdb v4.3-2.6.3-rc4-common-1.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQFAMaMEi4UHNye0ZOoRAvK0AKDcUK+D4WyjEzo8UveqGfcm+BMFyACdFdkV
2NPH5Om1bartd0odZtzvoRA=
=v64X
-----END PGP SIGNATURE-----

