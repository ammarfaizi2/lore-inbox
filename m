Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261855AbTCaTHq>; Mon, 31 Mar 2003 14:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261853AbTCaTHp>; Mon, 31 Mar 2003 14:07:45 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:39179 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S261851AbTCaTHm>; Mon, 31 Mar 2003 14:07:42 -0500
Date: Mon, 31 Mar 2003 14:14:20 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Jeremy Jackson <jerj@coplanar.net>
cc: Ron House <house@usq.edu.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: hdparm and removable IDE?
In-Reply-To: <1048860279.1615.13.camel@contact.skynet.coplanar.net>
Message-ID: <Pine.LNX.3.96.1030331140112.32749A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Mar 2003, Jeremy Jackson wrote:

> On Thu, 2003-03-27 at 22:21, Ron House wrote:
> > Bill Davidsen wrote:

> > > There was a bunch of discussion of this, possibly on this list, and I
> > > believe that the whole cable has to be unregistered or some such. I've
> > > done it with only one drive on a cable, and it seemed to work. On the
> > > other hand I was only playing.
> 
> Yes, the whole cable.  You don't put more than one IDE device on one
> cable, do you?  IDE TCQ may help performance in those cases (how will
> IDE bus to disconnect/*reconnect*?) But hot swap will always affect both
> cables.

Boy I hope that's a typo... I hope you meant both devices on a cable and
not really both cables on a controller.

And as for more than one device on a cable, I wouldn't expect hot swap to
work, but sure I have have a ZIP drive on a cable with a 2nd CD-ROM drive,
I use ZIP about as often as my cat farts Channel No5, I don't tie up a
cable for something which may go a year between uses. Don't use the
standby 16x CD more than a few times a year, either.

The removable drive I did get working was on its own old controller. And
it worked fine, I copied a fair number of old 420MB drives to CD after
they came out of machines which might have had something useful. Just in
case I ever think of something worth a treasure hunt. The drives were
wiped and used for a software RAID proof of concept project.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

