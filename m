Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268665AbTCCWgd>; Mon, 3 Mar 2003 17:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268666AbTCCWgd>; Mon, 3 Mar 2003 17:36:33 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:2233 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S268665AbTCCWgc>; Mon, 3 Mar 2003 17:36:32 -0500
From: David Lang <david.lang@digitalinsight.com>
To: John Bradford <john@grabjohn.com>
Cc: root@chaos.analogic.com, alan@lxorguk.ukuu.org.uk, hch@infradead.org,
       pavel@janik.cz, pavel@ucw.cz, linux-kernel@vger.kernel.org
Date: Mon, 3 Mar 2003 09:50:07 -0800 (PST)
Subject: Re: BitBucket: GPL-ed KitBeeper clone
In-Reply-To: <200303031508.h23F8FEI000787@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.4.44.0303030948310.29949-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the big reason for haveing it be compatable with existing systems is so
that if people move to it and decide they don't like it they can move away
from it again.

you may like to think that your program is so good that people will never
want to move away, but if it isn't an option then people will be very slow
to adopt it as the risk to their source history just went up a few
notches.

David Lang


 On Mon, 3 Mar 2003, John Bradford wrote:

> Date: Mon, 3 Mar 2003 15:08:15 +0000 (GMT)
> From: John Bradford <john@grabjohn.com>
> To: root@chaos.analogic.com
> Cc: alan@lxorguk.ukuu.org.uk, hch@infradead.org, pavel@janik.cz, pavel@ucw.cz,
>      linux-kernel@vger.kernel.org
> Subject: Re: BitBucket: GPL-ed KitBeeper clone
>
> > > > > I haven't seen a single post to the list saying, "If we were designing
> > > > > a version control system dedicated to the Linux kernel, what would you
> > > > > like to see in it?".  Before I started work on my bug database, I
> > > > > spent a week or so discussing it on the list with people.
> > > >
> > > > Larry spent a lot of time talking to people directly about such things.
> > >
> > > I meant in relation to Bit Bucket.
> > >
> > > If the need for Bit Keeper to make a profit for Bit Mover excludes
> > > Linux developers from using it, the most logical thing to do in my
> > > opinion is to start from scratch and write a version control system
> > > dedicated to furthering Linux kernel development.
> > >
> > > Compatibility with Bit Keeper should not be a goal of that project.
> >                                 ^^^^^^^^^^^^^^^^^^^^
> > Hmmm. Compatibility with existing things is always one of the
> > considerations of any new product (or project).
>
> I did consider it, I just don't think it's a good idea.
>
> > If compatibility can be achieved without a significant trade-off in
> > performance, then it should become one of the goals.
>
> Agreed, but in a project to develop the best possible version control
> system for the Linux kernel [1], I don't see how compatibility with
> any other version control system is of any interest at all.
>
> It's only if you want to use several version control systems in
> parallel that it might be an issue, but if a single, free, version
> control system is in use, I don't see why that would be necessary.
>
> Getting the data out of Bit Keeper and in to a different version
> control system is a one-time job, and as far as I am aware there is
> no difficulty getting data out of a Bit Keeper repository, (using Bit
> Keeper itself), in a suitable format.
>
> [1] As distinct from projects to develop the best possible version
> control system in general or to develop a GPLed project to complete
> with Bit Keeper.
>
> John.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
