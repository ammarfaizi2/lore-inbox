Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286722AbRLVIZF>; Sat, 22 Dec 2001 03:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286723AbRLVIYz>; Sat, 22 Dec 2001 03:24:55 -0500
Received: from femail25.sdc1.sfba.home.com ([24.254.60.15]:65188 "EHLO
	femail25.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S286722AbRLVIYp>; Sat, 22 Dec 2001 03:24:45 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Mike Jagdis <jaggy@purplet.demon.co.uk>, esr@thyrsus.com
Subject: Re: Configure.help editorial policy
Date: Fri, 21 Dec 2001 19:23:13 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20011220143247.A19377@thyrsus.com> <3C2310A4.1010004@purplet.demon.co.uk>
In-Reply-To: <3C2310A4.1010004@purplet.demon.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011222082444.EXOZ22539.femail25.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 December 2001 05:36 am, Mike Jagdis wrote:
> Eric S. Raymond wrote:
> > I guess it's a pretty quiet week in kernel-hacker land.  Must be,
> > otherwise people would have better things to do than argue over KB
> > vs. KiB.  The alternative would be to conclude that significant
> > portions of the lkml population prefer flaming to coding, and that
> > couldn't possibly be the case, could it?
>
> Surely not?
>
> > However.  In the *absence* of a clear consensus, I will follow best
> > practices.  Best practice in editing a technical or standards document
> > is to (a) avoid ambiguous usages, seek clarity and precision; and (b)
> > to use, follow and reference international standards.
>
> "Best" practice? That's the *only* practice! Guesswork and assumption
> has no place in technical documentation!

This may be why Andrea Arcangelli refuses to write any documentation at all, 
Linus seems to have a prediliction for dropping documentation-only patches, 
why the stuff in /linux/documentation has fallen up to two years out of date 
at times, and why "Rusty's Unreliable Guides" (the best source of 
documentation on the netfilter code, made available by the author himself at 
"http://netfilter.samba.org/unreliable-guides/") says, and I quote:

-----

The Linux Documentation Project has the noble goal to `create the canonical 
set of free Linux documentation'. 

The Open Source Writer's Group wants `to put together a comprehensive "card 
catalogue" of Open Source and Open Source-related documentation'. 

On the other hand, my pet hamster dressed up in a penguin suit, and appeared 
to me in a dream, telling me to write documentation for random stuff, and 
include lots of obscenities. 

The LDP guys no longer return my EMails (from me or my hamster). 

-----

On the net, the way to get information isn't to ask questions, but to post 
errors.  Questions get ignored more often than errors go unflamed.  Perfect 
documentation, like perfect code, isn't something you wait until you have 
before proceeding.

Rob
