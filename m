Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313181AbSEYRdw>; Sat, 25 May 2002 13:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314101AbSEYRdv>; Sat, 25 May 2002 13:33:51 -0400
Received: from air-2.osdl.org ([65.201.151.6]:3343 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S313181AbSEYRdu>;
	Sat, 25 May 2002 13:33:50 -0400
Date: Sat, 25 May 2002 10:31:24 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Larry McVoy <lm@bitmover.com>
cc: Erwin Rol <erwin@muffin.org>, <linux-kernel@vger.kernel.org>,
        RTAI users <rtai@rtai.org>
Subject: Re: RTAI/RtLinux
In-Reply-To: <20020525090537.G28795@work.bitmover.com>
Message-ID: <Pine.LNX.4.33L2.0205251019130.18051-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 25 May 2002, Larry McVoy wrote:

| On Sat, May 25, 2002 at 11:05:32AM +0200, Erwin Rol wrote:
| > Both Linus and Larry seem to be not very interested in hard-realtime
| > Linux additions, this is OK.
|
| I'm interested in hard realtime.  I'm extremely uninterested in changes
| to the mainline source base in order to get them.  That's exactly why
| I like the RT/Linux approach so much, it is the least invasive to the
| kernel and - surprise - also has the best performance.
|
| If people were to learn that real time and multi-user throughput are
| by definition mutually exclusive, I'd be a lot happier.  As it is,
| we have the SGI/Montevista crowd cramming their stuff into the kernel

In this example, SGI and MV are at opposite ends of the
spectrum, right?  High-end servers vs. embedded (and maybe RT).

I expect that most of the continued growth of Linux will be
in these 2 areas (servers and embedded) -- but we can't just
abondon the desktop/workstation space either.
Having 1 person say that Linux has problems in the embedded space
doesn't carry much weight with me, but having 2-3 other people
confirm it does start to concern me.

| and each "little" thing makes the kernel a less pleasant place to be
| and brings it one step closer to the point when it gets abandoned
| like ever other OS in the history of our field.

What I'd like to see/hear is a discussion about how to
accommodate all of these OS spaces (servers, workstations,
mobile, embedded) without making Linux ugly (or uglier in a
few cases).  Maybe a good topic for discussion in Canada...
in a hallway or a bar or a BOF.

Maybe the embedded/RT space is always maintained outside of
the kernel.org kernel tree; I don't know.
But certainly parts of the high-end server space want to be
included in the mainstream kernel.org tree.

Sorry about adding something non-legal to the discussion.
Not.

-- 
~Randy

