Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288814AbSA3ICO>; Wed, 30 Jan 2002 03:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288921AbSA3IBc>; Wed, 30 Jan 2002 03:01:32 -0500
Received: from adsl-187-220.38-151.net24.it ([151.38.220.187]:26385 "EHLO
	karis.localdomain") by vger.kernel.org with ESMTP
	id <S288957AbSA3IAr>; Wed, 30 Jan 2002 03:00:47 -0500
Message-Id: <200201300803.g0U83uB24903@karis.localdomain>
Date: Wed, 30 Jan 2002 09:03:55 +0100
From: Francesco Munda <syylk@libero.it>
To: LK <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <a354iv$ai9$1@penguin.transmeta.com>
In-Reply-To: <200201282213.g0SMDcU25653@snark.thyrsus.com>
	<200201290137.g0T1bwB24120@karis.localdomain>
	<a354iv$ai9$1@penguin.transmeta.com>
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2002 03:23:11 +0000 (UTC)
torvalds@transmeta.com (Linus Torvalds) wrote:

> One "patch penguin" scales no better than I do. In fact, I will claim
> that most of them scale a whole lot worse. 

I could hardly disagree.

> In short: don't try to come up with a "patch penguin".  Instead try to
> help existing maintainers, or maybe help grow new ones. THAT is the way
> to scalability.

Ok, I won't come up with anything. :)

I just heard a bell ringing, with Rob's message. It's still a faint ring, but
the debate spurred on l-k has shown that the bell is indeed ringing
somewhere. Many opinions were quite harsh on you, some even ungrateful; I'm
sorry if this caused any trouble.

What I see (from the viewpoint of some random user giving a try to test
kernels just for the fun of doing it) is not a problem with subsys
maintainers. I don't even _see_ them, from my pov. I trust them because you
do, and that's enough for me.

But I start to feel the need for someone to throw me an "unified development
tree". Like -ac was in 2.4: some source you trust from which pulling a kernel
to be tested. I need it, or better I prefer it over a forest of cross-patched
subtrees where I can find kernels bleedingly optimized in some area and
lacking trivial fixes in others.

A matter of convenience, actually. To which you can just answer "go away,
lazy scum". And probably will! :)

But also convenience for you.

You says, righteously, that you want tested patches. OTOH, to have them
tested, peer review would want to have them available somewhere to be tested,
for us crunching drones. Eventually in a tree where I can easily find all the
patches which are subject to scrutiny.

So we both could take advantage of what you call a "layer": someone (better:
more than someone - one man doesn't scale) who gathers stuff and readies ONE
unified, test-time-ready kernel, who has all the reviewing eyeballs, who goes
at you with the results of the tests, re-chunkifying(tm) the patches, and
letting you discard what you don't like and keep the (tested) things you see
fitting.

In the upper spheres, there could be a split of workload between who packages
the kernel to be thrown to the test-dogs (AC in the past, DJ now, ore than
one man in the future?), and who actually pioneers code and steers the kernel
after the packager gathers enough feedback from testers (that's you, wow! :)
).

Of course there has to be trust at that level, and I agree with you that
without trust with few, very selected people, you can't go ahead blindly
gathering debris from everyone.

In short: I think there are too many concurrent, overlapping development
trees, with a web of crosspatches that are honestly difficult to follow from
my "download, make, lilo, reboot, report" viewpoint. A fragmentation in the
to-be-tested code. A single "reference development" tree would be most
welcome.

I didn't intend to ask it to *you*. Probably natural evolution of kernel
development will pop out a good solution anyway.

The "patch penguin" as solution is just an idea. Bad as you want, but it
comes from a sensation Rob had. And I feel it too. And maybe others, less
silly than me.

The idea is rejectable, of course. The sensation, a bit less.

Have fun,

-- Francesco Munda
