Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287291AbRL3A0N>; Sat, 29 Dec 2001 19:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287286AbRL3A0D>; Sat, 29 Dec 2001 19:26:03 -0500
Received: from waste.org ([209.173.204.2]:54488 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S287288AbRL3AZz>;
	Sat, 29 Dec 2001 19:25:55 -0500
Date: Sat, 29 Dec 2001 18:25:53 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Larry McVoy <lm@bitmover.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: The direction linux is taking
In-Reply-To: <20011229160442.E21760@work.bitmover.com>
Message-ID: <Pine.LNX.4.43.0112291807170.18183-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Dec 2001, Larry McVoy wrote:

> On Sat, Dec 29, 2001 at 05:59:15PM -0600, Oliver Xymoron wrote:
> > > > > Is it really true that there are any significant number of patches
> > > > > submitted that don't even compile?
> > > >
> > > > No
> > >
> > > OK, so there are no significant numbers of patches that the patchbot will
> > > eliminate, by your admission.
> >
> > Except for the ones that get garbage collected after each new kernel
> > release WHEN THE VALIDITY OF THE QUEUE IS RECHECKED.
>
> Which is how many?  Do you have _any_ data which shows that this is going
> to do anything?

Yes. Every patch that goes by that says 'resynced with kernel x+1'. Which
seems to be a decent fraction of the ones that people care about. And an
ever larger percentage with each release. You've been on the list a few
years, you have the same data I have.

One of the stated problems with jitterbug was that it got cluttered with
stuff that never got kicked off. This is just part of the method of
kicking it off, the other (sigh, would have been nice if you'd read my
original message rather than latching on to a small part of the thread
that followed) was a system for quickly kicking stuff off the queue
manually.

> Great, so set it up, write a parser that grabs all the patches out of the
> list, run them through your system, and report back how much it helps.

My impression is that quite a bit of stuff (the majority?) never shows up
on the list at all, being fed directly to maintainers. And I obviously
can't say much about the manual reject side of things, not being Linus.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

