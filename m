Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.com) by vger.kernel.org via listexpand
	id <S261155AbRELD7p>; Fri, 11 May 2001 23:59:45 -0400
Received: (majordomo@vger.kernel.com) by vger.kernel.org
	id <S261159AbRELD5m>; Fri, 11 May 2001 23:57:42 -0400
Received: from zeus.kernel.org ([209.10.41.242]:49800 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261162AbRELD5a>;
	Fri, 11 May 2001 23:57:30 -0400
Date: Fri, 11 May 2001 21:57:59 -0400 (EDT)
From: Tom Diehl <tdiehl@pil.net>
X-X-Sender: <tdiehl@localhost.localdomain>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: 2.4.4ac7 oops, locks in init on boot
In-Reply-To: <E14yIBC-0001XM-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0105112153190.31744-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 May 2001, Alan Cox wrote:

> > If anyone has any further suggestions/patches to run 2.4.x with K7
> > chosen optimizations, I'm open to testing.
>
> 'Buy an AMD chipset box..'
>
> Seriously at this point I am out of ideas. The prefetch to far effect
> explained the old athlon locks (step 1) people reported on all chipsets. It
> didnt really seem to explain the problem with a few via chipset boards but I
> was hopeful.

So are you saying that given the current information available you have you
do not know how to fix the via -> Athlon stuff or am I reading too much
into this?

I am looking at buying an Athlon board soon and I am trying to figure out
if I should avoid via at all costs or not.

TIA,

-- 
......Tom		DISSERVICE: It Takes Months to Find a Customer, but
tdiehl@pil.net		Only Seconds to Lose One... The good News is that We
			Should Run Out of Them In No Time.

