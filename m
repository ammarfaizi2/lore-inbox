Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264586AbTLWORP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 09:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264942AbTLWORP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 09:17:15 -0500
Received: from [193.138.115.2] ([193.138.115.2]:2064 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S264586AbTLWORN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 09:17:13 -0500
Date: Tue, 23 Dec 2003 15:13:30 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Chris Frey <cdfrey@netdirect.ca>
cc: "Barry K. Nathan" <barryn@pobox.com>, Maciej Zenczykowski <maze@cela.pl>,
       Arnaud Fontaine <arnaud@andesi.org>, Mike Fedyk <mfedyk@matchmail.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Oops with 2.4.23
In-Reply-To: <20031222120557.A21530@netdirect.ca>
Message-ID: <Pine.LNX.4.56.0312231510140.28119@jju_lnx.backbone.dif.dk>
References: <20031219224402.GA1284@scrappy> <Pine.LNX.4.44.0312200034560.15516-100000@gaia.cela.pl>
 <20031222021659.GA4857@ip68-4-255-84.oc.oc.cox.net> <20031222120557.A21530@netdirect.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 22 Dec 2003, Chris Frey wrote:

> On Sun, Dec 21, 2003 at 06:17:00PM -0800, Barry K. Nathan wrote:
> > On Sat, Dec 20, 2003 at 12:35:24AM +0100, Maciej Zenczykowski wrote:
> > > you did run memtest for a minimum dozen hours? sometimes it takes that
> > > long to find errors...
> >
> > On one machine (with a bad power supply, as it turned out) it took
> > memtest86 almost 18 hours to report an error. So 12 hours isn't enough
> > either.
> >
> > (On a related note, one machine that I tested with mprime's Torture Test
> > <http://www.mersenne.org/> took I think close to 43 hours to show a
> > failure. In that case I don't know if the failure was the CPU or the
> > motherboard, because in the end both failed on that system.)
>
> At what point do people start suspecting the kernel?
>
> I mean, I would hope the linux kernel is not so badly written as to stress
> the machine 24/7.  So after 12 hours of running memtest86 with clean
> results, does that not begin to point to a software error rather than
> hardware?
>
Personally I expect my hardware to be able to survive being stressed 24/7.
I'm not saying the kernel does that, but if it did I would consider my
hardware broken if it didn't survive.

/Jesper Juhl

