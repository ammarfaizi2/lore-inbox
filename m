Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264799AbTCCO60>; Mon, 3 Mar 2003 09:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265065AbTCCO60>; Mon, 3 Mar 2003 09:58:26 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:43012 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id <S264799AbTCCO6Z>; Mon, 3 Mar 2003 09:58:25 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200303031508.h23F8FEI000787@81-2-122-30.bradfords.org.uk>
Subject: Re: BitBucket: GPL-ed KitBeeper clone
To: root@chaos.analogic.com
Date: Mon, 3 Mar 2003 15:08:15 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk, hch@infradead.org, pavel@janik.cz, pavel@ucw.cz,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1030303091452.22417B-100000@chaos> from "Richard B. Johnson" at Mar 03, 2003 09:22:14 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > I haven't seen a single post to the list saying, "If we were designing
> > > > a version control system dedicated to the Linux kernel, what would you
> > > > like to see in it?".  Before I started work on my bug database, I
> > > > spent a week or so discussing it on the list with people.
> > > 
> > > Larry spent a lot of time talking to people directly about such things.
> > 
> > I meant in relation to Bit Bucket.
> > 
> > If the need for Bit Keeper to make a profit for Bit Mover excludes
> > Linux developers from using it, the most logical thing to do in my
> > opinion is to start from scratch and write a version control system
> > dedicated to furthering Linux kernel development.
> > 
> > Compatibility with Bit Keeper should not be a goal of that project.
>                                 ^^^^^^^^^^^^^^^^^^^^
> Hmmm. Compatibility with existing things is always one of the
> considerations of any new product (or project).

I did consider it, I just don't think it's a good idea.

> If compatibility can be achieved without a significant trade-off in
> performance, then it should become one of the goals.

Agreed, but in a project to develop the best possible version control
system for the Linux kernel [1], I don't see how compatibility with
any other version control system is of any interest at all.

It's only if you want to use several version control systems in
parallel that it might be an issue, but if a single, free, version
control system is in use, I don't see why that would be necessary.

Getting the data out of Bit Keeper and in to a different version
control system is a one-time job, and as far as I am aware there is
no difficulty getting data out of a Bit Keeper repository, (using Bit
Keeper itself), in a suitable format.

[1] As distinct from projects to develop the best possible version
control system in general or to develop a GPLed project to complete
with Bit Keeper.

John.
