Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129143AbRAZDIa>; Thu, 25 Jan 2001 22:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130969AbRAZDIU>; Thu, 25 Jan 2001 22:08:20 -0500
Received: from mdmgrp3-86.accesstoledo.net ([207.43.108.86]:16393 "EHLO
	rosswinds.net") by vger.kernel.org with ESMTP id <S129143AbRAZDIB>;
	Thu, 25 Jan 2001 22:08:01 -0500
Date: Thu, 25 Jan 2001 22:20:10 -0500 (EST)
From: "Michael B. Trausch" <fd0man@crosswinds.net>
To: linux-kernel@vger.kernel.org
Subject: ECN and other sites
Message-ID: <Pine.LNX.4.21.0101252215070.4411-100000@fd0man.accesstoledo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've kinda been watching the ECN discussion there, and I have 2.4.0 and
noticed that after I'd installed it, I couldn't get to my favorite search
engine (Dogpile.com).  I'd assume they don't support it either, because
when I "echo 0 > /proc/sys/net/ipv4/tcp_ecn" then it goes away.  I
notified them about the problem and pointed them to a few webpages with
information and links regarding ECN.

Is there a kernel config option somewhere to disable that, or do I just
need to make sure to put that echo line in my /etc/rc.d/rc.local?

	- Mike

===========================================================================
Michael B. Trausch                                    fd0man@crosswinds.net
Avid Linux User since April, '96!                           AIM:  ML100Smkr

              Contactable via IRC (DALNet) or AIM as ML100Smkr
===========================================================================

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
