Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284079AbRLOWkg>; Sat, 15 Dec 2001 17:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284088AbRLOWk0>; Sat, 15 Dec 2001 17:40:26 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:19096 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S284079AbRLOWkL>; Sat, 15 Dec 2001 17:40:11 -0500
Message-ID: <3C1BDFBD.8BF59605@t-online.de>
Date: Sun, 16 Dec 2001 00:41:49 +0100
From: Gunther.Mayer@t-online.de (Gunther Mayer)
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: linux-kernel@vger.kernel.org, Andre Hedrick <andre@linux-ide.org>
Subject: Re: Dropped patches -> dropped bugfix 2.4 since months !
In-Reply-To: <Pine.LNX.4.10.10112151049260.13398-100000@master.linux-ide.org> <3C1BA20B.48FF8735@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Andre Hedrick wrote:
> > Well blame that on the folks that are not taking kernel code that will
> > allow you to solve this problem.  Linus is the number one offender.
> 
> Linus is taking some patches and not others right now...  so what?  A
> couple of my patches, isolated and clearly unrelated to bio and mochel's
> driver work, made it in.  Others got dropped.
> 
> I see several people (not just you Andre) whining about the dropped
> patches, when it seems to clear to me that only a few things in specific
> areas are getting applied right now.  For you specifically, Andre, Jen's
> patches have been slated for 2.5.x for a while, so it seems blindingly
> obvious that he would not take your IDE patches at least until the bio
> subsystem is finished and clean, since you IDE patches would clearly
> depend on the bio changes.
> 
> I do not believe this as a personal condemnation of your patches, or
> bcrl's, or anyone else's.
> 
> Patience is a virtue ;-)   We have a long devel series in front of us
> and we are only at the pre-patches to the FIRST 2.5.x release.

Unfortunately, Andre's patch includes an important BUGFIX which must
go into 2.4 (CompactFlash hang/IRQ storm on pcmcia-PCI adapter card).

Despite I'm sending this bugifx for several months now it is not included yet!

I understand Andre would like to get the whole patch accepted as I have no
evidence he ever submitted my isolated (about 3-liner) bugfix.

Andre, what are your plans concerning 2.4 ?
