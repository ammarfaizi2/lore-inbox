Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284118AbRLOXSd>; Sat, 15 Dec 2001 18:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284124AbRLOXSX>; Sat, 15 Dec 2001 18:18:23 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:32786
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S284118AbRLOXSO>; Sat, 15 Dec 2001 18:18:14 -0500
Date: Sat, 15 Dec 2001 15:12:28 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Gunther Mayer <Gunther.Mayer@t-online.de>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: Dropped patches -> dropped bugfix 2.4 since months !
In-Reply-To: <3C1BDFBD.8BF59605@t-online.de>
Message-ID: <Pine.LNX.4.10.10112151510100.13810-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I acknowledge the validity of the patch to you and Linus and agreed for
its need.  As you can see he has not got a clue nor could you sell him
one.  His additude toward laptops is /dev/null, otherwise he would have
taken the patches a long time ago and had the infrastructure for proper
APM calls in place.

Regards,

On Sun, 16 Dec 2001, Gunther Mayer wrote:

> Jeff Garzik wrote:
> > 
> > Andre Hedrick wrote:
> > > Well blame that on the folks that are not taking kernel code that will
> > > allow you to solve this problem.  Linus is the number one offender.
> > 
> > Linus is taking some patches and not others right now...  so what?  A
> > couple of my patches, isolated and clearly unrelated to bio and mochel's
> > driver work, made it in.  Others got dropped.
> > 
> > I see several people (not just you Andre) whining about the dropped
> > patches, when it seems to clear to me that only a few things in specific
> > areas are getting applied right now.  For you specifically, Andre, Jen's
> > patches have been slated for 2.5.x for a while, so it seems blindingly
> > obvious that he would not take your IDE patches at least until the bio
> > subsystem is finished and clean, since you IDE patches would clearly
> > depend on the bio changes.
> > 
> > I do not believe this as a personal condemnation of your patches, or
> > bcrl's, or anyone else's.
> > 
> > Patience is a virtue ;-)   We have a long devel series in front of us
> > and we are only at the pre-patches to the FIRST 2.5.x release.
> 
> Unfortunately, Andre's patch includes an important BUGFIX which must
> go into 2.4 (CompactFlash hang/IRQ storm on pcmcia-PCI adapter card).
> 
> Despite I'm sending this bugifx for several months now it is not included yet!
> 
> I understand Andre would like to get the whole patch accepted as I have no
> evidence he ever submitted my isolated (about 3-liner) bugfix.
> 
> Andre, what are your plans concerning 2.4 ?
> 

Andre Hedrick
CEO/President, LAD Storage Consulting Group
Linux ATA Development
Linux Disk Certification Project

