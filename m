Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130449AbRAWXPj>; Tue, 23 Jan 2001 18:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131614AbRAWXP3>; Tue, 23 Jan 2001 18:15:29 -0500
Received: from adsl-63-202-13-20.dsl.snfc21.pacbell.net ([63.202.13.20]:4106
	"EHLO earth.zigamorph.net") by vger.kernel.org with ESMTP
	id <S130449AbRAWXPN>; Tue, 23 Jan 2001 18:15:13 -0500
Date: Tue, 23 Jan 2001 23:14:38 +0000 (UTC)
From: Adam Fritzler <mid@earth.zigamorph.net>
To: Bart Dorsey <echo@thebucket.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with Madge Tokenring (abyss.o) in 2.4.1-pre10
In-Reply-To: <Pine.LNX.4.21.0101230832550.25107-100000@www>
Message-ID: <Pine.LNX.4.21.0101232313220.26932-100000@earth.zigamorph.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I was planning on submitting a MAINTAINERS patch with my next tms380tr
patchset, but I've yet to get to doing that (!).  

Thanks for the patch, Jeff!

---
  Adam Fritzler
  { mid@zigamorph.net, adam@activebuddy.com }
    http://www.zigamorph.net/~mid/

On Tue, 23 Jan 2001, Bart Dorsey wrote:

> I've tried to contact the driver maintainer, but his email bounced.
> 
> I constantly get this message on the console while using a Madge Smart
> 16/4 PCI Mk2 (Abyss) token ring card.
> 
> kernel: Warning: kfree_skb on hard IRQ d08cfea9
> 
> My quick "not knowing what I'm doing" fix was to comment out the
> printk. ;)
> 
> I dunno if this is the right place to ask, but maybe the maintainer will
> see this message, or perhaps someone else can pick up the ball on this
> one.
> 
> Thanks,
> Bart Dorsey
> echo@thebucket.org
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
