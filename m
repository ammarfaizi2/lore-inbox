Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263834AbUEXCd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263834AbUEXCd5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 22:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263840AbUEXCd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 22:33:56 -0400
Received: from agminet03.oracle.com ([141.146.126.230]:43929 "EHLO
	agminet03.oracle.com") by vger.kernel.org with ESMTP
	id S263834AbUEXCdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 22:33:54 -0400
Date: Sun, 23 May 2004 19:33:05 -0700
From: Wim Coekaerts <wim.coekaerts@oracle.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Phy Prabab <phyprabab@yahoo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 4g/4g for 2.6.6
Message-ID: <20040524023305.GC27372@ca-server1.us.oracle.com>
References: <20040523194302.81454.qmail@web90007.mail.scd.yahoo.com> <Pine.LNX.4.58.0405231329460.25502@ppc970.osdl.org> <40B10EC1.3030602@pobox.com> <Pine.LNX.4.58.0405231854240.25502@ppc970.osdl.org> <40B15BB5.4040508@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40B15BB5.4040508@pobox.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think the switchover will happen fairly rapidly, since it is 
> positioned "the upgrade you get next time you buy a new computer", 
> similar to the current PATA->SATA switchover.

you're thinking what people do at home, the large business side doesn't
throw stuff out.. let me know when rhat replaces every desktop with
amd64, and ll buy you a drink if that's within the next few years ;)

> Since these CPUs run in 32-bit mode just fine, I bet you wind up with 
> people running Intel or AMD 64-bit CPUs long they abandon their 32-bit 
> OS.  I recall people often purchasing gigabit ethernet cards long before 
> they had a gigabit switch, simply because it was the volume technology 
> that was being at the time.  I think the same thing is going to happen 
> here, with AMD64 and EM64T.

yeah well what we can do (and do) is advice that hey 64bit, in some form
is really a much better environment to run servers with lots of gb on.
just takes time for products to mature on the market, even today you
can't get a lot of those boxes, not in bulk, and I am not talking about
a 1 or 2 way or a desktop with 2gb. don't confuse the systems where
4/4gb matters with your home box.

on the plus side, all the changes that went in recently seem to work
mighty well on 32gb, and I still have to see the first 64gb ia32 boxes,
m sure they are out there but I doubt that really matters any more. 

anyhow, the current VM seems to be capable of 32gb systems on ia32
happily without needing ugly 4/4. which is awesome. it's also
interesting  timing. anywys, 2.6 kicks butt quite decently :)

Wim

