Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266210AbSLSU3R>; Thu, 19 Dec 2002 15:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266218AbSLSU3R>; Thu, 19 Dec 2002 15:29:17 -0500
Received: from air-2.osdl.org ([65.172.181.6]:21660 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266210AbSLSU3P>;
	Thu, 19 Dec 2002 15:29:15 -0500
Date: Thu, 19 Dec 2002 12:32:13 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Dave Jones <davej@codemonkey.org.uk>
cc: John Bradford <john@grabjohn.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Dedicated kernel bug database
In-Reply-To: <20021219201811.GA7715@suse.de>
Message-ID: <Pine.LNX.4.33L2.0212191229380.30841-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[cc list trimmed]

On Thu, 19 Dec 2002, Dave Jones wrote:

| On Thu, Dec 19, 2002 at 07:52:29PM +0000, John Bradford wrote:
|  > > I also don't trust things like this where if something goes wrong,
|  > > we could lose the bug report.
|  > How?  I don't see as that is more likely than with Bugzilla.
|
| user submits bug report
| robot rejects it
| user reads rejection, gets confused, gives up.
|
|  > Anyway, loads of LKML posts get ignored, and nobody seems to worry about it :-).
|
| Point to one important posting thats been ignored in recent times.
| More likely they weren't ignored, it was just deemed irrelevant,
| unimportant, or lacked information detailing how important the problem
| was.

It can be difficult to tell the difference.

| Besides, this is one area where bugzilla is helping.
| If I ignored/missed an agp related bug report on linux kernel,
| and the same user also filed it in bugzilla, I'll get pestered
| about it automatically later.
|
|  > I don't see any way of making Bugzilla do all the things I described
|  > originally, specifically the advanced tracking of versions tested.
|
| I still think you're solving a non-problem. Of the 180 or so bugs so
| far, there has been _1_ vendor kernel report. 1 2.4 report. and
| 1 (maybe 2)  undecoded oopses (which were subsequently decoded less
| than 24hrs later.
|
|  > That could help to find duplicates, which is a big problem when you
|  > have 1000+ bugs.
|
| In an ideal world, we'd never have that many open bugs 8-)
| Realistically, I check bugzilla a few times a day, I notice
| when something new has been added. Near the end of each week
| I[*] go through every remaining open bug looking to see if there's
| something additional that can be added / pinging old reporters /
| closing dead bugs. Dupes usually stand out doing this.
| How exactly do you plan to automate dupe detection ?
| You can't even do things like comparing oops dumps, as they
| may have been triggered in different ways,.
|
| 		Dave
|
| [*] and hopefully, I'm not the only one who does this.

Yes, I go thru them fairly often also, looking for patches or to apply some
patches to close some if possible.
I hope we aren't the only ones...

-- 
~Randy

