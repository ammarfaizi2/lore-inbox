Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129292AbRAaMvY>; Wed, 31 Jan 2001 07:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129561AbRAaMvP>; Wed, 31 Jan 2001 07:51:15 -0500
Received: from mdmgrp1-235.accesstoledo.net ([207.43.106.235]:1284 "EHLO
	rosswinds.net") by vger.kernel.org with ESMTP id <S129292AbRAaMvJ>;
	Wed, 31 Jan 2001 07:51:09 -0500
Date: Mon, 29 Jan 2001 21:03:55 -0500 (EST)
From: "Michael B. Trausch" <fd0man@crosswinds.net>
To: linux-kernel@vger.kernel.org
Subject: PPP broken in Kernel 2.4.1?
Message-ID: <Pine.LNX.4.21.0101292100520.460-100000@fd0man.accesstoledo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi.

I'm having a weird problem with 2.4.1, and I am *not* having this problem
with 2.4.0.  When I attempt to connect to the Internet using Kernel 2.4.1,
I get errors about PPP something-or-another, invalid argument.  I've tried
with and without devfs, I thought that may have been the problem as it was
the only new thing that I enabled in this kernel build, however, that
didn't make a difference.  I used all the same options that I have used in
past kernels, including 2.4.0, and I'm totally stumped as to the cause of
this problem =/.

If this is a known issue or something, sorry about the traffic.  I just
got through several hours of kernel recompiling making sure I didn't maybe
inadvertantly do something wrong, and I wound up having to rebuild 2.4.0
anyways.  (I forgot to make a "permanent" .old.2.4.0 copy of it, being
that the make install overwrites /vmlinuz.old).

	Thanks,
	Mike

===========================================================================
Michael B. Trausch                                    fd0man@crosswinds.net
Avid Linux User since April, '96!                           AIM:  ML100Smkr

              Contactable via IRC (DALNet) or AIM as ML100Smkr
===========================================================================

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
