Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbUBUAta (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 19:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbUBUAta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 19:49:30 -0500
Received: from pr-117-210.ains.net.au ([202.147.117.210]:54468 "EHLO
	mail.ocs.com.au") by vger.kernel.org with ESMTP id S261454AbUBUAt0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 19:49:26 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: kdb@oss.sgi.com, linux-kernel@vger.kernel.org
Cc: linux-ia64@vger.kernel.org
Subject: Re: Announce: kdb v4.3 is available for kernel 2.6.3 
In-Reply-To: Your message of "Wed, 18 Feb 2004 17:08:16 +1100."
             <10769.1077084496@kao2.melbourne.sgi.com> 
Date: Sat, 21 Feb 2004 11:49:10 +1100
Message-ID: <23594.1077324550@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

KDB (Linux Kernel Debugger) has been updated.

ftp://oss.sgi.com/projects/kdb/download/v4.3/

Current versions are :-
  kdb-v4.3-2.6.3-common-2.bz2
  kdb-v4.3-2.6.3-i386-1.bz2
  kdb-v4.3-2.6.3-ia64-1.bz2

Warning: the 2.6 versions of kdb have had minimal testing.  In
particular they have not been tested with CONFIG_PREEMPT.

Changelog extract since kdb-v4.3-2.6.3-common-1.

2004-02-21 Keith Owens  <kaos@sgi.com>

	* Correct build of kdb_cmds when using a separate object directory and
	  make it quiet.  j-nomura (NEC), Keith Owens.
	* kdb v4.3-2.6.3-common-2.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQFANqsGi4UHNye0ZOoRApmUAKDcT+Vwa4BcYqtSTQ1VWmLfAhxchgCfY7mS
sOVcf3MS2JaYpncY0jbFO+I=
=oIMt
-----END PGP SIGNATURE-----

