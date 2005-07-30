Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263052AbVG3LeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263052AbVG3LeN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 07:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbVG3LeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 07:34:13 -0400
Received: from web30304.mail.mud.yahoo.com ([68.142.200.97]:56745 "HELO
	web30304.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S263053AbVG3LeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 07:34:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=1HOhTYserzftx4B+DRkv0tNf4aDCOHI6tL1Hb3Xuo+AzY3sXrd/D05QDFXYNveyDFpha9YAKY9MeHQaa5emXWvoM6+OyTqWwcHNaARCgjNnXWZY7EvbpAwNtff1RQ8N3RYp8eNJ+PDdZjEXEGu2knVQTv6ajzGaSMrxtccVMaV0=  ;
Message-ID: <20050730113350.62722.qmail@web30304.mail.mud.yahoo.com>
Date: Sat, 30 Jul 2005 12:33:50 +0100 (BST)
From: Mark Underwood <basicmark@yahoo.com>
Subject: Re: [patch] ucb1x00: touchscreen cleanups
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Pavel Machek <pavel@ucw.cz>, rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050730102236.B9652@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> On Tue, Jul 26, 2005 at 09:04:12AM +0100, Mark
> Underwood wrote:
> > I am in the process of porting Linux 2.6.11.5 to
> the
> > Helio PDA (MIPS R3912 based) and if I remember
> > correctly it is using a UCB1x00 (or Toshiba
> clone).
> > Please could you make sure your patches will work
> > across arch.
> 
> Which UCB1x00 version?  There's about three of them
> - 1200, 1300 and
> 1400.  The 1200 and 1300 are non-AC'97 devices,
> which are targetted
> by this driver.

It is the UCB1200 (also known as the Toshiba TC35143F
or Betty).

> 
> > Now I have my kernel up and running (well
> > mainly falling :-() my next task is to get write
> the
> > frame buffer driver and then look at the UCB1x00
> as I
> > need it for sound and touch screen. So in a day or
> two
> > I will start to try to integrate your work into my
> > kernel.
> 
> Note that I'm maintaining the code and will be
> publishing a new set
> of patches for it based upon Pavel's fixes.

Thanks. I'll check them out then.

> 
> -- 
> Russell King
>  Linux kernel    2.6 ARM Linux   -
> http://www.arm.linux.org.uk/
>  maintainer of:  2.6 Serial core
> 



	
	
		
___________________________________________________________ 
Yahoo! Messenger - NEW crystal clear PC to PC calling worldwide with voicemail http://uk.messenger.yahoo.com
