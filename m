Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262606AbUJ1BRC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262606AbUJ1BRC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 21:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262614AbUJ1BRC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 21:17:02 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:31440 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262606AbUJ1BPO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 21:15:14 -0400
Date: Thu, 28 Oct 2004 03:14:44 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrea Arcangeli <andrea@novell.com>, Larry McVoy <lm@work.bitmover.com>,
       Joe Perches <joe@perches.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Larry McVoy <lm@bitmover.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: BK kernel workflow
In-Reply-To: <Pine.LNX.4.58.0410271409420.28839@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.61.0410272340000.877@scrub.home>
References: <Pine.LNX.4.58.0410191510210.2317@ppc970.osdl.org>
 <20041023161253.GA17537@work.bitmover.com> <4d8e3fd304102403241e5a69a5@mail.gmail.com>
 <20041024144448.GA575@work.bitmover.com> <4d8e3fd304102409443c01c5da@mail.gmail.com>
 <20041024233214.GA9772@work.bitmover.com> <20041025114641.GU14325@dualathlon.random>
 <1098707342.7355.44.camel@localhost.localdomain> <20041025133951.GW14325@dualathlon.random>
 <20041025162022.GA27979@work.bitmover.com> <20041025164732.GE14325@dualathlon.random>
 <Pine.LNX.4.58.0410251017010.27766@ppc970.osdl.org>
 <Pine.LNX.4.61.0410252350240.17266@scrub.home> <Pine.LNX.4.58.0410251732500.427@ppc970.osdl.org>
 <Pine.LNX.4.61.0410270223080.877@scrub.home> <Pine.LNX.4.58.0410261931540.28839@ppc970.osdl.org>
 <Pine.LNX.4.61.0410272049040.877@scrub.home> <Pine.LNX.4.58.0410271409420.28839@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 27 Oct 2004, Linus Torvalds wrote:

> The alternative to me using BitKeeper would be patches and tar-balls. 
> Which you already have. So why are you complaining? BK isn't taking 
> anything away from you.. 

Linus, what happened to the early promises, that the data wouldn't be 
locked into bk? Is the massively reduced data set in the cvs repository 
really all we ever get out of it again?

> Since you seem to be blind to the problem, let's try it one more time. 
> 
> The BK license is _exactly_ the same issue as with the GPL. In the GPL, 
> the rule is "tit for tat" - you get to play with the sources, but in 
> exchange you have to give out your modifications. Some people complain 
> about that, and I call them worthless whiners.
> 
> In the BK license, it's "tit for tat". You get to use Larry's program, in 
> exchange for not competing with him. Some people complain about that, and 
> I call them worthless whiners.
> 
> See the pattern? In both cases, the answer is: if you don't like it, don't 
> use it. And in both cases, if you don't use it, you are no worse off than 
> if it didn't exists, so it's not like the existence of GPL'd programs or 
> BK is making your life any worse.

You can play this game with every license, if a licence had no conditions 
it wouldn't be a license anymore. If you want to get anywhere with this, 
why don't you look at the purpose of the license?
The only purpose of the bk license is to protect the business case of its 
owner with all its consequences, which you are trying very hard to avoid 
to discuss.
One of these consequences is that you cannot convert that repository on 
your harddisk into a different format, no matter behind how many firewalls 
you hide it. This makes your question for alternatives rather pointless, 
you couldn't use them anyway, even if they existed, unless you want to 
throw away the current history.
Why are you avoiding to discuss these consequences? Your actions as kernel 
maintainer don't happen in isolation, they have an effect on other people, 
positive as negative. Concentrating only on the positive and doing 
personal attacks can't hide the reality forever. Call me whatever you 
want if it makes you feel better, but I'll continue to look on both sides 
of the story.

I make a last attempt to make this more clear. I don't care what tools you 
use, I don't care if I can't use them, but why is it acceptable for you to 
cut off _any_ possibility for me to archive the same result in some other 
way? I don't want to drink away your beer and I don't want to control what 
you watch on your TV. We are talking about the kernel repository here, 
which is a shared resource a lot of people helped to create, but why is it
acceptable for you, that some of them can't benefit from it like the rest.
Linus, this is not some random project, this is a public project with 
higher moral standards, why is acceptable to have different moral 
standards during its development? A goal of Linux is it to preserve the 
freedom of its users, making them independent of a single vendor, why is 
it acceptable to make it a condition that developers have to commit 
themselves to a single vendor in order to get full access to the kernel 
repository?

bye, Roman
