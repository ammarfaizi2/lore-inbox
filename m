Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264959AbTLFG0v (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 01:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264960AbTLFG0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 01:26:51 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:30217 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id S264959AbTLFG0t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 01:26:49 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: kdb@oss.sgi.com
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Announce: kdb v4.3 is available for kernel 2.4.23 
In-Reply-To: Your message of "Mon, 01 Dec 2003 12:04:06 +1100."
             <2594.1070240646@kao2.melbourne.sgi.com> 
Date: Sat, 06 Dec 2003 17:26:40 +1100
Message-ID: <9771.1070692000@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

The latest version of the Linux Kernel Debugger (kdb) is in

ftp://oss.sgi.com/projects/kdb/download/v4.3/

Current versions are
  kdb-v4.3-2.4.23-common-2.bz2
  kdb-v4.3-2.4.23-i386-1.bz2
  kdb-v4.3-2.4.23-ia64-031205-1.bz2

ia64 has just been added.  Changelog extracts for ia64 since 2.4.22.

2003-12-06 Keith Owens  <kaos@sgi.com>

	* Coexist with the new salinfo interface.
	* Redo the workaround for backtrace through spinlock contention called
	  from leaf functions.
	* kdb v4.3-2.4.23-ia64-031205-1.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE/0Xagi4UHNye0ZOoRAiBZAJsFkZE9YNG7C8K8K9HJsl/7X4u3EQCfa2GK
2Nj2Ou21kJEEiiI5dCNYXj4=
=cfJG
-----END PGP SIGNATURE-----

