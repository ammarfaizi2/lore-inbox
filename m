Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131374AbQKNUi5>; Tue, 14 Nov 2000 15:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131377AbQKNUir>; Tue, 14 Nov 2000 15:38:47 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:55454 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131374AbQKNUid>;
	Tue, 14 Nov 2000 15:38:33 -0500
Date: Tue, 14 Nov 2000 15:08:28 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Michael Rothwell <rothwell@holly-springs.nc.us>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Advanced Linux Kernel/Enterprise Linux Kernel
In-Reply-To: <Pine.LNX.3.95.1001114113240.23765A-100000@chaos.analogic.com>
Message-ID: <Pine.GSO.4.21.0011141502540.5482-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 14 Nov 2000, Richard B. Johnson wrote:

> On Tue, 14 Nov 2000, Michael Rothwell wrote:
> 
> > "Richard B. Johnson" wrote:
> > > Multics???  [..] way too many persons on this list who know the history of
> > > Unix to try this BS.
> > 
> > So, you're saying their nine goals were bullshit? Multics had a lot of
> > problems. But it did a lot of ground-breaking. Perhaps you should reply
> > to the nine goals, or the general topic of "Enterpriseness," rather than
> > merely express your irrelevant hatred for Multics.
> >
> 
> Relating some "nine goals of 'Enterprise Computing'" to Multics is
> the bullshit. When Multics was being developed, the singular goal
> was to make an operating system that worked on DEC Equipment without
> having to use DEC software. The emphasis was on trying to make it
> work period.

WTF are you smoking? Multics never ran on DEC hardware. Moreover, your
ideas about UNIX history ("modified Multics bootloader" bit) are, well,
interesting. Porting from GE to PDP-7... <shudder> Besides, the thing
had wildly different fs usage model - "everything is mmaped segment" vs.
UNIX "everything is stream of characters".

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
