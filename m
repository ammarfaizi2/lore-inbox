Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268543AbTBOHMJ>; Sat, 15 Feb 2003 02:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268544AbTBOHMJ>; Sat, 15 Feb 2003 02:12:09 -0500
Received: from mailsrv.otenet.gr ([195.170.0.5]:42901 "EHLO mailsrv.otenet.gr")
	by vger.kernel.org with ESMTP id <S268543AbTBOHMH>;
	Sat, 15 Feb 2003 02:12:07 -0500
From: Aggelos Economopoulos <aoiko@cc.ece.ntua.gr>
Reply-To: aoiko@cc.ece.ntua.gr
To: Larry McVoy <lm@bitmover.com>
Subject: Re: openbkweb-0.0
Date: Sat, 15 Feb 2003 09:24:23 +0200
User-Agent: KMail/1.5
Cc: Jamie Lokier <jamie@shareable.org>, Larry McVoy <lm@bitmover.com>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
References: <1045273835.2961.0.camel@irongate.swansea.linux.org.uk> <200302150658.15080.aoiko@cc.ece.ntua.gr> <20030215053226.GA30867@work.bitmover.com>
In-Reply-To: <20030215053226.GA30867@work.bitmover.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200302150910.39599.aoiko@cc.ece.ntua.gr>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 15 February 2003 07:32, Larry McVoy wrote:
> On Sat, Feb 15, 2003 at 07:00:36AM +0200, Aggelos Economopoulos wrote:
> > On Saturday 15 February 2003 05:11, Jamie Lokier wrote:
> > [...]
> >
> > > [ Note that I won't agree to refrain from reverse engineering the
> > >   network protocol, as the price of using BK for free.
> > >
> > >   Chances are I'll never bother, but it's not something I'd willingly
> > >   agree to not do, because I prefer to be not allowed to use BK than
> > > to be effectively bound by an eternal NDA. ]
> >
> > What makes you think the licence is something like an _eternal_ NDA?
> >
> > Larry, I've used bitkeeper for a few months to pull linus's and rik's
> > trees and export them for my own use until about a month ago. I've also
> > tried using it in a single user repository for contest (the benchmark).
> >
> > Last week, feeling tempted to dig into arch, I removed all the files
> > from the bitkeeper installation and I did a search-and-unlink of
> > BitKeeper directories, just in case.
> >
> > Do you intend to sue me if I ever submit a patch for
> > cvs/subversion/whatever (arch kind of sucks:-) or if I feel like
> > starting my own scm project? (while I think this would be ridiculous
> > I'm not trying to bash you here, it's an honest question regarding
> > Jamie's comment above)
>
> Nobody wins in a lawsuit, at least not at this level.  I don't want to
> sue you, that's nuts.
>
> If you continued use BK and were working on an SCM system, yeah, we'd
> kick up a fuss.  Our position is that it was really hard to produce a
> system which doesn't suck and it is a lot easier to copy such a system
> than it is to invent one on your own.  So we'd prefer you to figure it
> out on your own than copy what we have done.

Which of course doesn't answer my question, but I guess it is only natural 
that you want to keep your options open.

Let me just point out that you have given out much more information about 
bitkeeper in your mails in lkml than any info one would hope to get by
using bitkeeper (except maybe by dissasembling it). I was familiar with all 
the bitkeeper concepts many months before I downloaded it (it's all on the 
website) and you have been arguing (successfully) for many of the design 
decisions you guys made (weave vs diff, distributed vs centralized etc).

So if I (or anybody else) were to start work on a competing project, I 
wouldn't even /feel/ I'm abusing your contribution to the community and 
since I've stopped using bitkeeper I'm quite certain I wouldn't be 
violating your licence.

Thanks for taking the time to aswer though.

Aggelos


