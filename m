Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262476AbSJETkH>; Sat, 5 Oct 2002 15:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262477AbSJETkG>; Sat, 5 Oct 2002 15:40:06 -0400
Received: from 62-190-216-136.pdu.pipex.net ([62.190.216.136]:37894 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S262476AbSJETjZ>; Sat, 5 Oct 2002 15:39:25 -0400
From: jbradford@dial.pipex.com
Message-Id: <200210051953.g95Jreqr001552@darkstar.example.net>
Subject: Re: The end of embedded Linux?
To: giduru@yahoo.com (Gigi Duru)
Date: Sat, 5 Oct 2002 20:53:40 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021005193650.17795.qmail@web13202.mail.yahoo.com> from "Gigi Duru" at Oct 05, 2002 12:36:50 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Trivial experiment: configure out _ALL_ the options on
> 2.5.38 and build bzImage. My result? A totally useless
> 270KB kernel (compressed). 
> 
> Now try to put in some useful stuff and the
> _compressed_ image will cheerfully approach 1MB. Where
> are the days when a 200KB kernel would be fully
> equipped?

That is completely wrong.  I run 2.5.40 on a swapless 8MB 486, and can happily use BASH, Apache with PHP support, Lynx, and JED, all at a useful speed.  I also happily run 2.5.40 on another 4MB RAM 486, with 20MB of swap, and do useful work on it.  If you don't believe me, come to Linux Expo UK next week and see for yourself.

> I know you guys are struggling to bring "world class
> VM & IO" to Linux, going for SMPs and other big toys,
> but you are about to lose what you already have: the
> embedded market.

No, the 2.0.x and 2.2.x kernels are actively maintained.

> As an embedded developer, I can't stand bloat. I think
> an OS designer should feel the same, and develop in a
> fully modular and configurable manner, going for both
> speed and size. For a long time I've felt that Linux
> has got it right, but lately I'm not that sure
> anymore. 

Nobody is forcing you to move to 2.4.x from older versions - current code is being actively backported to them.

John.
