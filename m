Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282530AbRLBAc5>; Sat, 1 Dec 2001 19:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282531AbRLBAcs>; Sat, 1 Dec 2001 19:32:48 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:62476 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S282530AbRLBAcl>; Sat, 1 Dec 2001 19:32:41 -0500
Date: Sat, 1 Dec 2001 16:43:15 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Victor Yodaiken <yodaiken@fsmlabs.com>,
        Rik van Riel <riel@conectiva.com.br>, Andrew Morton <akpm@zip.com.au>,
        Larry McVoy <lm@bitmover.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Henning Schmiedehausen <hps@intermeta.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Coding style - a non-issue
In-Reply-To: <Pine.LNX.4.33.0111302048200.1459-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.40.0112011620520.1696-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2001, Linus Torvalds wrote:

>
> On Fri, 30 Nov 2001, Victor Yodaiken wrote:
> >
> > Ok. There was no design, just "less than random mutations".
> > Deep.
>
> I'm not claiming to be deep, I'm claiming to do it for fun.
>
> I _am_ claiming that the people who think you "design" software are
> seriously simplifying the issue, and don't actually realize how they
> themselves work.
>
> > There was a overall architecture, from Dennis and Ken.
>
> Ask them. I'll bet you five bucks they'll agree with me, not with you.
> I've talked to both, but not really about this particular issue, so I
> might lose, but I think I've got the much better odds.
>
> If you want to see a system that was more thoroughly _designed_, you
> should probably point not to Dennis and Ken, but to systems like L4 and
> Plan-9, and people like Jochen Liedtk and Rob Pike.
>
> And notice how they aren't all that popular or well known? "Design" is
> like a religion - too much of it makes you inflexibly and unpopular.

The most successful software have born from fixing/patching an
initial/simple implementation while the greatest software failures
have born from deep planning and design.
And for successful I mean widely used/apreciated/longlived.
You start with a very limited ( in features ) initial version, people
happen to like it, you sell/distribute it and they're going to ask for new
features.
Some of these new features will fit the initial design some other will
make you patching it in an undesigned way, but you think that you'll fix
it later.
But people are going to like it even more and become more hungry of new
features, some of them will fit in the initial implementation design some
other will introduce crappy patching, but later time is fix time.
And so on.
What is the deep thought in this, it's that if you've time for deep
planning/design it means that nobody is actually using your software and
when your cutting edge, well designed implementation will see the light,
noone is gonna use it because they've already embraced something else.
Not cutting edge, not really deeply designed but a fu*king working real
software that is solving real problems for the 99% of its users.




- Davide



