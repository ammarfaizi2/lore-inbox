Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264231AbUGAHRB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264231AbUGAHRB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 03:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264236AbUGAHRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 03:17:01 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:49830 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S264231AbUGAHQ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 03:16:57 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: kdb@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: Announce: kdb v4.3 x86-64 updates for for kernel 2.4.25 
In-Reply-To: Your message of "Wed, 09 Jun 2004 11:30:10 +1000."
             <4850.1086744610@kao2.melbourne.sgi.com> 
Date: Thu, 01 Jul 2004 17:16:53 +1000
Message-ID: <10869.1088666213@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

KDB (Linux Kernel Debugger) has been updated.

ftp://oss.sgi.com/projects/kdb/download/v4.3/

kdb-v4.3-2.4.25-x86-64-1.bz2 is available.  The x86-64 patch is still a
work in progress, use with care.  Changelog extract.

2004-06-23 Jack Vogel <jfv@bluesong.net>
	* Port patch to 2.4.25 and sync with Keith's
	  4.3 common and i386 code.
	* By internal (IBM) request add cr8 to register dump

2003-12-15 Cliff Neighbors <cliff@fabric7.com>
	* initial port from i386 to x86_64

x86-64 for 2.4.25 requires kdb-v4.3-2.4.25-common-3 or later.


When Marcelo releases 2.4.27, I will do a backport of kdb v4.4 from 2.6
to 2.4.27, this is probably the last update for kdb v4.3.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQFA47pli4UHNye0ZOoRAq1MAKC7AAgihexkB5cmB689cdybKh6EDACfcTZw
5v/umYBg6Cn9lc4xZOnsq9I=
=RVDU
-----END PGP SIGNATURE-----

