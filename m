Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317707AbSFLODO>; Wed, 12 Jun 2002 10:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317708AbSFLODO>; Wed, 12 Jun 2002 10:03:14 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:15878 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S317707AbSFLODN>; Wed, 12 Jun 2002 10:03:13 -0400
Date: Wed, 12 Jun 2002 09:57:47 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Nick Evgeniev <nick@octet.spb.ru>, Andre Hedrick <andre@linux-ide.org>,
        linux-kernel@vger.kernel.org
Subject: Re: linux 2.4.19-preX IDE bugs
In-Reply-To: <E17I2bd-000732-00@the-village.bc.nu>
Message-ID: <Pine.LNX.3.96.1020612095106.337A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jun 2002, Alan Cox wrote:

> >   I agree that if it has known problems which destroy data it should be
> > unavailable in the stable kernel. It certainly sounds as if that's the
> > case, and the driver could be held out until 2.4.20 or so when it can be
> > fixed, or if it can't be fixed it can just go away.
> 
> Then I suggest you give up computing, because PC hardware doesnt make
> your grade. BTW the general open promise bugs *dont* include data
> corruption so I suspect it may be your h/w thats hosed.

Mine, and the original poster? And the "me too?" I understood the author
to say that the new board needed a driver change, and if that's the case
why not hold off the driver until he gets to it? Nobody if faulting him
for lack of time, but it seems not to work.

Guess it must be my hardware, two boards, two systems, corruption only on
the drives on the new... hell with it, obviously if you don't have the
problem the original poster and I must be clueless whiners.

I'll drop this discussion and scrap the board, restores cost more than
controllers :-(

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

