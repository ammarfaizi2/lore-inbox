Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130004AbRBOU7x>; Thu, 15 Feb 2001 15:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130194AbRBOU7n>; Thu, 15 Feb 2001 15:59:43 -0500
Received: from datafoundation.com ([209.150.125.194]:35332 "EHLO
	datafoundation.com") by vger.kernel.org with ESMTP
	id <S130004AbRBOU73>; Thu, 15 Feb 2001 15:59:29 -0500
Date: Thu, 15 Feb 2001 15:59:13 -0500 (EST)
From: John Jasen <jjasen@datafoundation.com>
To: Michal Jaegermann <michal@ellpspace.math.ualberta.ca>
cc: Andre Hedrick <andre@linux-ide.org>, <linux-kernel@vger.kernel.org>,
        <axp-list@redhat.com>
Subject: Re: 2.4.x/alpha/ALI chipset/IDE problems summary Re: 2.4.1 not fully
 sane on Alpha - file systems
In-Reply-To: <20010215134747.A13942@ellpspace.math.ualberta.ca>
Message-ID: <Pine.LNX.4.30.0102151557240.4654-100000@flash.datafoundation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Feb 2001, Michal Jaegermann wrote:

> Like I wrote - I did not get to locks on fsck but then stuff was weird
> and if I would press sufficiently long maybe I would.  I still had some
> use for my file systems so I did not try hard enough.  Maybe we need
> black hens on the top of the magic quoted above?

You bring the black hens, I've got the goats, red silk ribbon, and candles
...

> > I don't care about X on this system, all that much, honestly.
>
> "Technicolor" thingy seems to be side effect of your particular
> graphics card, no?

I gotta think that something Very Bad (tm) is happening at kernel level,
like something getting overrun in the IDE subsystem, and overwriting into
other areas of memory.

*shrug*

-- John

