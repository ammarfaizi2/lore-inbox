Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287203AbRL2WZO>; Sat, 29 Dec 2001 17:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286794AbRL2WZF>; Sat, 29 Dec 2001 17:25:05 -0500
Received: from waste.org ([209.173.204.2]:33237 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S287202AbRL2WZA>;
	Sat, 29 Dec 2001 17:25:00 -0500
Date: Sat, 29 Dec 2001 16:24:56 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Larry McVoy <lm@bitmover.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: The direction linux is taking
In-Reply-To: <20011229140914.B13883@work.bitmover.com>
Message-ID: <Pine.LNX.4.43.0112291611040.18183-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Dec 2001, Larry McVoy wrote:

> On Sat, Dec 29, 2001 at 02:30:36PM -0600, Oliver Xymoron wrote:
> > Nonsense. X is a release. At a minimum, a submitted patch should apply to
> > the current globally visible kernel release. If you want your patch to
> > go in, it has to be current, otherwise no use bothering the
> > maintainer. And it ought to compile.
>
> OK, so this glorious patchbot is going to make sure that a patch patches
> cleanly against a known version and compiles.  And that buys me exactly
> what?  Not a heck of a lot.  Especially since, as is obvious, if you send
> in stuff that doesn't compile consistently, your patches are likely to go
> to the back of the line or just get dropped.

It never shows up in the maintainer's inbox, leaving them more time to
address the remainder. And fewer of the increasingly bitter complaints of
dropped patches.

> > The purpose of the patchbot is to bounce patches that don't
> > apply/compile/meet whatever baseline before Maintainer ever has to look at
> > them, thus reducing the 'black hole effect' of the overloaded maintainer.
>
> I'd suggest you go try this idea out.  It's funny how often people suggest
> that they are going to make the problems go away, it's always this same
> proposal, typically nobody does any work, when they do it doesn't get used,
> could it be there is a reason for that?
>
> I'm prepared to be wrong, but I don't hear the maintainers asking for this
> patchbot.  Why not?

I don't hear them asking for SCM either.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

