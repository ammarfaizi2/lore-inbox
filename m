Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129913AbRAAW7p>; Mon, 1 Jan 2001 17:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131358AbRAAW7Z>; Mon, 1 Jan 2001 17:59:25 -0500
Received: from db0bm.automation.fh-aachen.de ([193.175.144.197]:40709 "EHLO
	db0bm.ampr.org") by vger.kernel.org with ESMTP id <S129853AbRAAW7P>;
	Mon, 1 Jan 2001 17:59:15 -0500
Date: Mon, 1 Jan 2001 23:28:38 +0100
From: f5ibh <f5ibh@db0bm.ampr.org>
Message-Id: <200101012228.XAA03423@db0bm.ampr.org>
To: grobh@sun.ac.za
Subject: Re: 2.4.0-prerelease, AX25 problems
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Hans,

You wrote :
> Is the "previous test version" you talk about 2.4.0-test13-pre7?  There
> weren't any changes since then that could explain this, except maybe:
Yes, I mean test13-pre[12134567] and other older versions too.
I've already had the problem some time ago with an older 2.4.0-testxx kernel.
I don't think it is directly related to the ax25 stuff but maybe (?) a timer
modified elsewhere ?

> Gnu C                  2.95.2
Possible too. These compilers problems (which one for which kernel) are a bit
boring...  Anyway, I've downloaded the correct version of the compiler and
retried the operation.

[root@debian-f5ibh] ~ # gcc -v
Reading specs from /usr/lib/gcc-lib/i586-pc-linux-gnu/egcs-2.91.66/specs
gcc version egcs-2.91.66 19990314 (egcs-1.1.2 release)

The result is the same than with the other compiler.

-----
Best wishes for 2001 for you and your family

		Jean-Luc
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
