Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbTJGA5I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 20:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbTJGA5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 20:57:08 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:36002 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S261772AbTJGA5E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 20:57:04 -0400
Date: Mon, 6 Oct 2003 17:56:57 -0700
From: Larry McVoy <lm@bitmover.com>
To: Olivier Galibert <galibert@pobox.com>,
       Pascal Schmidt <der.eremit@email.de>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org
Subject: Re: freed_symbols [Re: People, not GPL [was: Re: Driver Model]]
Message-ID: <20031007005657.GA11759@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Olivier Galibert <galibert@pobox.com>,
	Pascal Schmidt <der.eremit@email.de>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
References: <Dnwo.1ew.15@gated-at.bofh.it> <DnPL.3XB.11@gated-at.bofh.it> <DsvX.3yN.1@gated-at.bofh.it> <E1A6a6A-0000qT-00@neptune.local> <20031006183857.GA3508@work.bitmover.com> <20031006212942.GA61774@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031006212942.GA61774@dspnet.fr.eu.org>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.3,
	required 7, AWL)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 06, 2003 at 11:29:42PM +0200, Olivier Galibert wrote:
> On Mon, Oct 06, 2003 at 11:38:57AM -0700, Larry McVoy wrote:
> > That has no bearing on the legalities.  A version of the kernel can't
> > force the GPL on a driver that works with that version of the kernel
> > because you can pull that driver out and drop in another.  A great example
> > is the eepro driver, there is Becker's version and the Intel version.
> > Any judge who wasn't fooled by Microsoft priced lawyers would clearly
> > see the boundary and make a ruling that the GPL can't cross over it.
> 
> So you're saying the LGPL and the GPL mean the same thing for
> libraries?  That, for instance, you can handle Qt as if it was LGPL?

I think so, I'm afraid.  I know that this view of the law isn't what
people think is true and the end result may well be a court case which
tests it.

You can sort of see how the logic works.  There has to be some sort
of boundary, right?  Does anyone really think that if Linus hadn't
said that the GPL doesn't cross over to the user apps that the GPL
really would have crossed over?  So if there is a boundary concept,
how do you define what a boundary is?  Is that left to each license or
is that part of the law?  As far as I can tell, that's part of the law,
it has a concept of a boundary already.  The lawyers got a little squirmy
around this part and I got the sense that what is a boundary is not 
universally established.  But everyone seemed to think that allowing
licenses which bleed over into "unrelated" stuff is about as legal as
contracts imposing human slavery, i.e., both are not legal.

It's certainly not a done a deal, I think that sooner or later there will
be some court case that establishes the case law on which all future
cases will be based.  The people I know who care about the GPL dread
this case because the GPL has sort of had it both ways for a long time
and that can't continue.  If you want the law to be that SCO can't claim
all the IP that was built on top of the original Unix then that same law
also says that the GPL can't claim dominion over separable works either.

I can also image that the Qt people are less than thrilled with what I'm
saying because it basically invalidates the GPL-ed library or pay for a
non-GPLed version business model.

All of what I say should be taken with a grain of salt.  Yeah, I've spent
money trying to understand this and I perhaps understand more than some
people here (maybe a lot of people in this instance).  That doesn't mean
what I say is right.  If you really care, if your business depends on
it, you need to get a lawyer to work through the issues.  Right now,
I think the side with the deeper pockets would win, so even though I'm 
pointing at what I think will be the long term outcome, I'm not sure I'd
bet the farm on that.  How's that for weasel words?
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
