Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262877AbRE3W6s>; Wed, 30 May 2001 18:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262880AbRE3W6h>; Wed, 30 May 2001 18:58:37 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:45533 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S262877AbRE3W6c>;
	Wed, 30 May 2001 18:58:32 -0400
Date: Thu, 31 May 2001 00:57:54 +0200 (CEST)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: "Michael H. Warfield" <mhw@wittsend.com>
cc: Harald Welte <laforge@gnumonks.org>, Fabbione <fabbione@fabbione.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [OFF-TOPIC] 4 ports ETH cards
In-Reply-To: <20010530180344.A5304@alcove.wittsend.com>
Message-ID: <Pine.LNX.4.21.0105310053450.32433-100000@tux.rsn.bth.se>
X-message-flag: Get yourself a real mail client! http://www.washington.edu/pine/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 May 2001, Michael H. Warfield wrote:

[snip]
> 	Just got three of these suckers and I'm about to order a bunch
> more (happy camper)...

yes the Dlink DFE570-TX is a very nice card indeed.

[snip]
> 	Because the D-Link cards were less than half of the nearest
> competitor [ < $180 vs > $360 for others and Compac was > $2400! ] I
> ordered only three not knowing for sure if they would work.  Turned on
> the tulip driver and them suckers fired right up.  Now I know they work,
> stock, right out of the box, and I can order a bunch more for the lab
> I'm working with.

I use those cards in all routers here and they work extremely well.
But I don't use the standard vanilla tulip driver that's in the official
kernel. I use an optimized version that handled high traffic volumes much
better, it decreases the interrupt-load quite a lot. (this driver is about
to be merged with the standard tulip driver IIRC)
I havn't had any problems with these cards so I can really recommend them.

/Martin

