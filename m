Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266135AbTBPJnZ>; Sun, 16 Feb 2003 04:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266161AbTBPJnZ>; Sun, 16 Feb 2003 04:43:25 -0500
Received: from slider.rack66.net ([212.3.252.135]:8587 "EHLO slider.rack66.net")
	by vger.kernel.org with ESMTP id <S266135AbTBPJnX>;
	Sun, 16 Feb 2003 04:43:23 -0500
Date: Sun, 16 Feb 2003 10:58:09 +0100
From: Filip Van Raemdonck <filipvr@xs4all.be>
To: linux-kernel@vger.kernel.org
Subject: Re: openbkweb-0.0
Message-ID: <20030216095809.GA29161@debian>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030215215259.GA22512@work.bitmover.com> <200302152211.h1FMBK6a001200@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302152211.h1FMBK6a001200@darkstar.example.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 15, 2003 at 10:11:20PM +0000, John Bradford wrote:
> 
> From reading this thread, and the similar ones that have preceeded it,
> it seems to me that most people are not exactly bothered about using
> the SCM functionality of BitKeeper, but just want to get the
> up-to-the-second changes to Linus' tree.

Seems a fairly accurate analysis...

> I always thought that that is what the bk-commit mailing lists were
> for?  I could be wrong about that, not having used BitKeeper - if so,
> what are they for, and would it not be possible to simply have a
> mailing list which got sent a diff every time Linus' updated his tree?

... but the solution is not sufficient. What about people wanting to track
one of the ppc[1] trees? What about Alan wanting to get at that 3cr990
which was in a bk repository only before he asked for another format? What
about...?
The only real way to solve this with mailinglists is for the mailinglists
to be run by BitMover, for every repository they host. I doubt they like
that idea.

I'm not using bk to get at patches out of principle, but I can't be
bothered enough to get into arguments about what Larry must or mustn't do.
And it's mostly true that bitkeeper usage may not have really made the
situation worse. But it has improved the situation for people who do use
it while leaving the rest out in the cold, creating inequality among Linux
users and developers. Larry shouldn't be surprised to get flak for that,
regardless of what his intentions are.


Regards,

Filip

[1] There is a linuxppc-commit list I was recently told, but it turns out
    to be a comments-only list so it isn't useful for this. And there are
    rsync trees, but they are weeks out of date wrt the bk trees most of
    the time - and when Apple releases new hardware it's often necessary
    in the beginning to run the very last benh kernel for it to work.

-- 
"Much blood has been spilled as a result of arguments about how many buttons
 a mouse ought to have. Naive users prefer one (it is hard to push te wrong
 button if there is only one), but sophisticated ones like the power of
 multiple buttons to do fancy things."
	-- Andrew S. Tanenbaum, `Structured Computer Organization'
