Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbTEEWti (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 18:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbTEEWti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 18:49:38 -0400
Received: from landfill.ihatent.com ([217.13.24.22]:16790 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id S261454AbTEEWth
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 18:49:37 -0400
To: Patrick Mau <mau@oscar.ping.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.69, DRI, Radeon 8500 AGP working for me
References: <20030505195927.GA28347@oscar.ping.de>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 06 May 2003 01:01:54 +0200
In-Reply-To: <20030505195927.GA28347@oscar.ping.de>
Message-ID: <87isspxajh.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Patrick Mau <mau@oscar.ping.de> writes:

> Many thnks, Linus
> 
> The current BK 2.5 tree fixes all my DRI and AGP related problems.
> I did stress it very hard running various screensavers and quake 3,
> so far everything is all right.
> 
> I'm currently using XFree from CVS:
> 
> XFree86 Version 4.3.99.3
> Release Date: 29 April 2003
> X Protocol Version 11, Revision 0, Release 6.6
> Build Operating System: Linux 2.4.20 i686 [ELF]
> Build Date: 01 May 2003
> 
> "Page Flipping" and "AGP Fast Write" are enabled,
> AGP speed is set to "1" (the default ?).
> 

Radeon 7500 with 64Mb RAM ans 4xAGP now works like a charm here, first
time in a long time. Both kernel modules and XFree CVS works.

mvh,
A
- -- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQE+tu1fCQ1pa+gRoggRAn4TAJ42SqfK5Gv9AWliOjSUgqzKsvmhrgCfYXKB
B7U3krdVBjVhLnTPx0oYixg=
=XBMp
-----END PGP SIGNATURE-----
