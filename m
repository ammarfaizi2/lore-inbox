Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285461AbRLSUZk>; Wed, 19 Dec 2001 15:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285473AbRLSUZb>; Wed, 19 Dec 2001 15:25:31 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:2345 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S285458AbRLSUXU>; Wed, 19 Dec 2001 15:23:20 -0500
Date: Wed, 19 Dec 2001 15:23:17 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200112192023.fBJKNHn09269@devserv.devel.redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: aio
In-Reply-To: <mailman.1008792601.3391.linux-kernel2news@redhat.com>
In-Reply-To: <E16Gjuw-0000UT-00@starship.berlin> <Pine.LNX.4.33.0112190859050.1872-100000@penguin.transmeta.com> <20011219135708.A12608@devserv.devel.redhat.com> <mailman.1008792601.3391.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > It's AIO we're talking about, right?  AIO is interesting to quite a few
> > > > people.  I'd read the thread.  I'd also read any background material 
> > > > that Ben would be so kind as to supply.
> > > 
> > > Case closed.
> > > 
> > > Dan didn't even _know_ of the patches.

> I've got a fairly recent version of the patch too, it's a little too long to 
> just sit down and read, to reverse-engineer the above information.

Heh, I agree, in a way. I did that once, did not find any major
objections and documented about 20 small things like functions
that have extra arguments which are never used, etc. Ben saw it
and said "I know about all that, never mind".
Perhaps I should have had posted it somewhere?

-- Pete
