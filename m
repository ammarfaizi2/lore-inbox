Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbUJ0CNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbUJ0CNe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 22:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbUJ0CNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 22:13:33 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:19146 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261576AbUJ0CNI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 22:13:08 -0400
Date: Wed, 27 Oct 2004 04:05:04 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrea Arcangeli <andrea@novell.com>, Larry McVoy <lm@work.bitmover.com>,
       Joe Perches <joe@perches.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Larry McVoy <lm@bitmover.com>, akpm@osdl.org
Subject: Re: BK kernel workflow
In-Reply-To: <Pine.LNX.4.58.0410251732500.427@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.61.0410270223080.877@scrub.home>
References: <Pine.LNX.4.58.0410191510210.2317@ppc970.osdl.org>
 <20041023161253.GA17537@work.bitmover.com> <4d8e3fd304102403241e5a69a5@mail.gmail.com>
 <20041024144448.GA575@work.bitmover.com> <4d8e3fd304102409443c01c5da@mail.gmail.com>
 <20041024233214.GA9772@work.bitmover.com> <20041025114641.GU14325@dualathlon.random>
 <1098707342.7355.44.camel@localhost.localdomain> <20041025133951.GW14325@dualathlon.random>
 <20041025162022.GA27979@work.bitmover.com> <20041025164732.GE14325@dualathlon.random>
 <Pine.LNX.4.58.0410251017010.27766@ppc970.osdl.org>
 <Pine.LNX.4.61.0410252350240.17266@scrub.home> <Pine.LNX.4.58.0410251732500.427@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 25 Oct 2004, Linus Torvalds wrote:

> The only thing I blame Andrea for is _whining_. Don't get me wrong, I 
> don't blame him for the bad state of CVS or anything like that.

You must be seeing something I don't. Andrea was objecting to how Larry 
was practically declaring defeat for the "bk haters", how you're defining 
this as whining I don't know.

> The fact is, Andrea doesn't actually do anything constructive when it 
> comes to SCM. He just complains every time somebody says something 
> positive about a product that (a) he didn't do anything for and (b) nobody 
> forces him to use, and (c) there are no real alternatives for today (much 
> less the three years ago he was whining about).

Miles already mentioned that you're wrong here and I don't really know 
what you expect here from him.

> > The ability to handle big amounts of patches includes also the
> > possibility to merge a lot of crap. What keeps up the general quality?
> 
> No SCM is _ever_ going to be a quality manager.

No disagreement here, but that wasn't really point I was trying to make.

> And that's what Andrea is doing. Sure, BK is commercial, but dammit, so is
> that 2GHz dual-G5 too and that Shuttle box in my corner. They happen to be
> the tools I use for what I do. If Andrea told me that I should use a
> slower machine because that's what most people use, I'd consider him a
> total idiot. Similarly, when he complains that people use software tools
> that clearly _do_ make them more productive, I consider his complaint
> stupid.

Your analogy is flawed, nobody cares what you are using privately, but 
your decisions as kernel maintainer have an effect on other people, may 
this be the patches you include in the next release or the tools you 
distribute them with.
In the end it's your decision what tools you use, if you think the 
advantages outweigh the license which goes contrary to the open 
devolopment process, that's fine, but so have other people the right to 
disagree with that decision. Maybe you could make some suggestion on how 
to articulate this more politically correct?
Linus, what disturbs me here is that I don't see that you don't even try 
to acknowledge that the bk license might be part of problem, you don't 
mention the bk license with a single word. Nobody hates bk, that's a myth 
I'd expect from Larry but not from you. bk is a rather innocent and 
certainly useful tool, the annoying part are the business practices of its 
owner, who tries to push a licence into an environment, where it has to 
provoke rejection.

bye, Roman
