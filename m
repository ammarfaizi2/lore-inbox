Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284545AbRLRSrx>; Tue, 18 Dec 2001 13:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284664AbRLRSqh>; Tue, 18 Dec 2001 13:46:37 -0500
Received: from [62.58.73.254] ([62.58.73.254]:62708 "EHLO
	ats-core-0.atos-group.nl") by vger.kernel.org with ESMTP
	id <S284694AbRLRSpj>; Tue, 18 Dec 2001 13:45:39 -0500
Date: Tue, 18 Dec 2001 19:42:32 +0100 (CET)
From: <rsweet@atos-group.nl>
To: John Alvord <jalvo@mbay.net>
cc: Dana Lacoste <dana.lacoste@peregrine.com>,
        "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
        <linux-kernel@vger.kernel.org>
Subject: RE: The direction linux is taking
In-Reply-To: <Pine.LNX.4.20.0112181005290.12820-100000@otter.mbay.net>
Message-ID: <Pine.LNX.4.30.0112181928520.15130-100000@core-0>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[...]
> > Many bug reports don't end up in the right place.
> > (i.e. a Sparc patch on the LKML but not the Sparc-Linux mailing lists)
[...]
> > For example. Red Hat's knowledge base is a piece of crap.  It's
> > impossible to find anything because of the millions of variations
> > on different products.
[...]
> > I sincerely challenge you to propose a method for centralizing
> > bug tracking in the Linux kernel that _can_ be used by the
> > community as a whole.  That means something that Linus would use
> > _and_ somebody who doesn't subscribe to LKML can use to find out
> > why he can't compile loop.o on his redhat 7.0 system with the
> > kernel he got from kernel.org a few weeks ago.

We have one already.  Its called google.  The trouble is that (as with any
other system one might propose) one has to know how to search effectively.

If any of the 800 folks who posted "loop.o" doesn't compile had bothered
to search google first with some decent parameters they would have seen
that the issue was identified and a solution posted almost immediately.
The same for the example of bugs going to the wrong list.  If I have a
problem with sparc linux would I search only on the sparc linux list?
No, I would spend a few minutes to carefully craft some google queries and
weed through the results first.

Sure, there are many weaknesses: it takes a lot of intuition and sometimes
time to sort through massive results, and any discussion that doesn't go
into public lists doesn't get archived.  I'm not convinced that any more
specific solution would solve these problems in a significant enough way
to justify changing things as they are currently.

I suppose another thing we lose is data mining for info about bugs that
have been reported/resolved/merged over time.  I'm not sure if that sort
of info would be useful or not.  I suspect that a clever enough perl monk
could even extract that sort of information from google without too much
effort.


-- 
Ryan Sweet <ryan.sweet@atosorigin.com>
Atos Origin Engineering Services
http://www.aoes.nl

