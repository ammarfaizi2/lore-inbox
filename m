Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287233AbRL2XEr>; Sat, 29 Dec 2001 18:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287224AbRL2XE2>; Sat, 29 Dec 2001 18:04:28 -0500
Received: from bitmover.com ([192.132.92.2]:34984 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S287214AbRL2XEY>;
	Sat, 29 Dec 2001 18:04:24 -0500
Date: Sat, 29 Dec 2001 15:04:23 -0800
From: Larry McVoy <lm@bitmover.com>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: The direction linux is taking
Message-ID: <20011229150423.G19306@work.bitmover.com>
Mail-Followup-To: Oliver Xymoron <oxymoron@waste.org>,
	Larry McVoy <lm@bitmover.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20011229140914.B13883@work.bitmover.com> <Pine.LNX.4.43.0112291611040.18183-100000@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.43.0112291611040.18183-100000@waste.org>; from oxymoron@waste.org on Sat, Dec 29, 2001 at 04:24:56PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29, 2001 at 04:24:56PM -0600, Oliver Xymoron wrote:
> > OK, so this glorious patchbot is going to make sure that a patch patches
> > cleanly against a known version and compiles.  And that buys me exactly
> > what?  Not a heck of a lot.  Especially since, as is obvious, if you send
> > in stuff that doesn't compile consistently, your patches are likely to go
> > to the back of the line or just get dropped.
> 
> It never shows up in the maintainer's inbox, leaving them more time to
> address the remainder. And fewer of the increasingly bitter complaints of
> dropped patches.

I think it's great that Oliver is volunteering to build this system,
host it, provide the build infrastructure and hardware, that's cool!  But
wouldn't it be a whole lot less work to tell people to type make before 
they send in the patch?

Doesn't it seem a bit strange to be building a system to make sure that
the people who submit patches have submitted patches which compile?
Is it really true that there are any significant number of patches
submitted that don't even compile?  

And while we are the build topic, what platforms get built?  What configs?

> > I'm prepared to be wrong, but I don't hear the maintainers asking for this
> > patchbot.  Why not?
> 
> I don't hear them asking for SCM either.

OK Socrates, nice try, but try and stay focussed and answer the question.
It's right there above your non-answer.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
