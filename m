Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136702AbRAIAY4>; Mon, 8 Jan 2001 19:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136751AbRAIAYq>; Mon, 8 Jan 2001 19:24:46 -0500
Received: from linuxcare.com.au ([203.29.91.49]:47366 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S136702AbRAIAYa>; Mon, 8 Jan 2001 19:24:30 -0500
From: Rusty Russell <rusty@linuxcare.com.au>
To: linux-kernel@vger.kernel.org
Cc: "Jeremy M. Dolan" <jmd@foozle.turbogeek.org>
Subject: Re: Extraneous whitespace removal? 
In-Reply-To: Your message of "Mon, 08 Jan 2001 04:42:18 MDT."
             <20010108044218.A9610@foozle.turbogeek.org> 
Date: Tue, 09 Jan 2001 11:24:20 +1100
Message-Id: <E14FmaK-0000NJ-00@halfway>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20010108044218.A9610@foozle.turbogeek.org> you write:
> Pluses:
>  - clean up messy whitespace
>  - cut precious picoseconds off compile time
>  - cut kernel tree by 200k (+/- alot)

I've done this before, but never posted it, lest they think I'm
insane.  I vote this for 2.5.1.

You, sir, have balls,
Rusty.
--
http://linux.conf.au The Linux conference Australia needed.
--- working-2.4.0/MAINTAINERS.~1~	Mon Jan  1 04:31:15 2001
+++ working-2.4.0/MAINTAINERS	Tue Jan  9 11:23:48 2001
@@ -1434,6 +1434,11 @@
 L:	linux-scsi@vger.kernel.org
 S:	Maintained
 
+WHITESPACE
+P:	Jeremy M. Dolan
+M:	jmd@foozle.turbogeek.org
+S:	Maintained
+
 X.25 NETWORK LAYER
 P:	Henner Eisen
 M:	eis@baty.hanse.de
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
