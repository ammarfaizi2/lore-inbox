Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbTIXD2c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 23:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbTIXD2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 23:28:32 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:33441
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S261361AbTIXD21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 23:28:27 -0400
Date: Wed, 24 Sep 2003 05:28:37 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Larry McVoy <lm@work.bitmover.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <willy@debian.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Larry McVoy <lm@bitmover.com>
Subject: Re: log-buf-len dynamic
Message-ID: <20030924032837.GP16314@velociraptor.random>
References: <20030924024831.GO16314@velociraptor.random> <Pine.LNX.4.44.0309231955350.27467-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309231955350.27467-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 08:06:51PM -0700, Linus Torvalds wrote:
> 
> On Wed, 24 Sep 2003, Andrea Arcangeli wrote:
> > 
> > I wasn't whining about BK at all, nor about the licence, I just
> > advertized the open links in my signature, the word "refuse" may be not
> > a nice one, I didn't feel to be rude when I wrote it, now I changed it
> > and I hope it's a more friendly wording, though the meaning it's the
> > same.
> 
> Andrea, be honest.
> 
> This latest thing didn't start with just the signature. In fact, the 

the latest not, but that was the latest, and I still recommend Marcelo
to stop using bitkeeper and to do the checkins directly in cvs. That
would be a start and it would motivate me more too into adding more
effort there.

I need a bit of feedback from a kernel maintainer that there will be a
slight chance to use something non bitkeeper in the future before I
invest a bit of (probably my spare) time into this.

>   "if Marcelo would be using open source code to exports the patchsets in
>    his tree, we could fix it to add the email address along the name in the
>    checkin logs metadata, to avoid this sort of mistakes."
> 
> That quote is not just some small snippet: it is the _entirety_ of new 
> material in the whole post. 

yes that was the whole point of the email. That was a suggestion for
Marcelo.

> >  I only said I'm not applying to the licence and _you_ have to respect
> > my _right_ not to use the software and to advertize the _open_ links,
> > without seeing it as an offensive thing.
> 
>  (a) It wasn't all you said
>  (b) I can, and do, get offended by postings to public non-religious lists
>      that have no redeeming value except to push your religious views.
> 
> I despise people who come up to me in the street (or even worse - ring the
> doorbell on my house) to tell me about Jesus, and how they found happiness
> in him.
> 
> Good for you and your buddy Jesus/buddha/Moses/AlienFromAnotherPlanet. But
> get the _hell_ out of my face. If I come to your church to listen to your
> sermons, that's when I'll respect your right to tell me.  But if you stand
> up with a megaphone in the park when I'm having a picknick, I'd much
> rather kick your sorry ass the h*ll out of there.
> 
> So go to gnu.misc.discuss if you want to discuss the immorality of 

Really I don't find anything immoral, nor religious here. I only care
about law. Law says if I use bitkeeper I can't develop in the same area,
and so I refuse to use it. it's as simple as that.

To me it looks like you're confusing law and free market, with religion.

To make an example, I used netscape for years, netscape was the only
reasonable software at the time, and I would have never expected that
they would release the sources anytime soon, nor I was extremely
interested into it, since netscape just worked fine (on alpha I used the
tru64 version for a long time too). I preferred an open alternative but
there wasn't so I happily used netscape. I still used netscape for a
long time even when mozilla was usable because some website didn't work
with mozilla and I had no time to fix it myself. The netscape licence
was acceptable to me to use for something not critical for me like
browsing the web (I mean who cares if netscape crashes). I can make lots
more examples like that. I don't feel religious about stuff, and you
certainly can't claim I'm religious because I refuse to giveup my rights
to fix or improve cvs or subversion or to write a filesystem with
versioning, that may effectively collide with future jobs as well.
that's about freedom, not religion.

Andrea - If you prefer relying on open source software, check these links:
	    rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
	    http://www.cobite.com/cvsps/
	    svn://svn.kernel.org/linux-2.[46]/trunk
