Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264886AbSLBTrA>; Mon, 2 Dec 2002 14:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264925AbSLBTq7>; Mon, 2 Dec 2002 14:46:59 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:34579 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S264886AbSLBTqx>; Mon, 2 Dec 2002 14:46:53 -0500
Date: Mon, 2 Dec 2002 14:52:56 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG]2.5.49-ac1 - more info on make error
In-Reply-To: <Pine.LNX.4.33L2.0212021103150.27194-100000@dragon.pdx.osdl.net>
Message-ID: <Pine.LNX.3.96.1021202144705.433L-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Dec 2002, Randy.Dunlap wrote:

> On Mon, 2 Dec 2002, Bill Davidsen wrote:

> | No. I have pretty much assumed that there is no interest in having this
> | work. The modules are broken to the point where either the author or
> | someone who has documentation on how they should work will have to fix
> | them. Clearly the policy of "if you want your change in the kernel you
> | have to fix what it breaks" is dead.
> 
> This is not the borked-modules problem; it's different.

I misread, I thought it came about when changes for module interface were
applied.

> | I posted that to the list, if it didn't make it for any reason I can't
> | easily recreate it, the machine has been converted to BSD, the 2.5 work is
> | on a removable drive which is removed, since we can't make any progress
> | with it for the moment.
> 
> whatever.  Adrian Bunk & Jeff Garzik have now posted patches for it.

Yes, I've noted my thanks earlier, particularly for some info on the
underlying cause, which will be useful when I see that problem again. 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

