Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269807AbUJWBhk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269807AbUJWBhk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 21:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269586AbUJWBhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 21:37:39 -0400
Received: from waste.org ([209.173.204.2]:25769 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S269820AbUJWBfn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 21:35:43 -0400
Date: Fri, 22 Oct 2004 20:35:18 -0500
From: Matt Mackall <mpm@selenic.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The naming wars continue...
Message-ID: <20041023013518.GI31237@waste.org>
References: <Pine.LNX.4.58.0410221431180.2101@ppc970.osdl.org> <20041022234631.GF28904@waste.org> <20041023011549.GK17038@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041023011549.GK17038@holomorphy.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 06:15:49PM -0700, William Lee Irwin III wrote:
> On Fri, Oct 22, 2004 at 03:05:13PM -0700, Linus Torvalds wrote:
> >> And the fact is, I can't see the point. I'll just call it all "-rcX",
> >> because I (very obviously) have no clue where the cut-over-point from
> >> "pre" to "rc" is, or (even more painfully obviously) where it will become
> >> the final next release.
> 
> On Fri, Oct 22, 2004 at 06:46:31PM -0500, Matt Mackall wrote:
> > This should be easy: the cut-over should be when you're tempted to
> > rename it 2.6.next. If you have no intention (or hope) of renaming
> > 2.6.x-rc1 to 2.6.x, it is not a "release candidate" by definition.
> > What's the point? It serves as a signal that a) we're not accepting
> > more big changes b) we think it's ready for primetime and needs
> > serious QA c) when 2.6.next gets released, the _exact code_ has gone
> > through a test cycle and we can have some confidence that there won't
> > be any nasty 0-day bugs when we go to install 2.6.next on a production
> > machine.
> 
> I'm sure you have a well-founded logically consistent self-consistent
> method of defining what release candidates are; unfortunately hordes of
> others do, too, and their notions are in turn all subtly inconsistent
> with yours and each other's, and they're all relatively vocal about them.

Mine is the trivial one: a release candidate is something that is
intended as a candidate for release. I'm not suggested anything about
requirements for code quality, yadda yadda, just that there's an
intent to release the release candidates should they pass muster. That
does not appear to be the intent with most 2.6-rc of late.

> On Fri, Oct 22, 2004 at 03:05:13PM -0700, Linus Torvalds wrote:
> >> (*) In other words, I had a beer and watched TV. Mmm... Donuts.
> 
> On Fri, Oct 22, 2004 at 06:46:31PM -0500, Matt Mackall wrote:
> > Please devote some more beer and TV to this problem after you release
> > 2.6.10.
> 
> Give the emperor penguin a break.

But I did! He's got until after 2.6.10. 

(yes, that probably warrants a smiley)

> On Fri, Oct 22, 2004 at 06:46:31PM -0500, Matt Mackall wrote:
> > Mathematics is the supreme nostalgia of our time.
> 
> It would be nice if this were qualified with something that distinguished
> the outlandish idealizations you're actually criticizing from real math,
> which makes no presumption that its axioms or hypotheses have any
> connection to reality, observations, or predictions thereof. The abuse
> you're speaking of is poor modelling for the sake of tractability of
> symbolic calculations, which has nothing to do with proof or logic.

Actually just the opposite. It's more about Godel and Whitehead than
Feynmann in my interpretation.

-- 
Mathematics is the supreme nostalgia of our time.
