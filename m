Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269726AbUJWBTW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269726AbUJWBTW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 21:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269600AbUJWBQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 21:16:50 -0400
Received: from holomorphy.com ([207.189.100.168]:6600 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269727AbUJWBQF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 21:16:05 -0400
Date: Fri, 22 Oct 2004 18:15:49 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Matt Mackall <mpm@selenic.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The naming wars continue...
Message-ID: <20041023011549.GK17038@holomorphy.com>
References: <Pine.LNX.4.58.0410221431180.2101@ppc970.osdl.org> <20041022234631.GF28904@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041022234631.GF28904@waste.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 03:05:13PM -0700, Linus Torvalds wrote:
>> And the fact is, I can't see the point. I'll just call it all "-rcX",
>> because I (very obviously) have no clue where the cut-over-point from
>> "pre" to "rc" is, or (even more painfully obviously) where it will become
>> the final next release.

On Fri, Oct 22, 2004 at 06:46:31PM -0500, Matt Mackall wrote:
> This should be easy: the cut-over should be when you're tempted to
> rename it 2.6.next. If you have no intention (or hope) of renaming
> 2.6.x-rc1 to 2.6.x, it is not a "release candidate" by definition.
> What's the point? It serves as a signal that a) we're not accepting
> more big changes b) we think it's ready for primetime and needs
> serious QA c) when 2.6.next gets released, the _exact code_ has gone
> through a test cycle and we can have some confidence that there won't
> be any nasty 0-day bugs when we go to install 2.6.next on a production
> machine.

I'm sure you have a well-founded logically consistent self-consistent
method of defining what release candidates are; unfortunately hordes of
others do, too, and their notions are in turn all subtly inconsistent
with yours and each other's, and they're all relatively vocal about them.


On Fri, Oct 22, 2004 at 03:05:13PM -0700, Linus Torvalds wrote:
>> (*) In other words, I had a beer and watched TV. Mmm... Donuts.

On Fri, Oct 22, 2004 at 06:46:31PM -0500, Matt Mackall wrote:
> Please devote some more beer and TV to this problem after you release
> 2.6.10.

Give the emperor penguin a break. There's bound to be enough weighing
on him as it is with just the usual barrage of technical issues. The
new release process hasn't even been given a chance to fail yet as the
two commercial distros with the largest userbases haven't even gotten
to the point where they've both released 2.6 yet, and debian isn't
using 2.6 as the install kernel yet either.


On Fri, Oct 22, 2004 at 06:46:31PM -0500, Matt Mackall wrote:
> Mathematics is the supreme nostalgia of our time.

It would be nice if this were qualified with something that distinguished
the outlandish idealizations you're actually criticizing from real math,
which makes no presumption that its axioms or hypotheses have any
connection to reality, observations, or predictions thereof. The abuse
you're speaking of is poor modelling for the sake of tractability of
symbolic calculations, which has nothing to do with proof or logic.


-- wli
