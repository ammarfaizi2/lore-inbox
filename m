Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287130AbRL2WJo>; Sat, 29 Dec 2001 17:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286933AbRL2WJf>; Sat, 29 Dec 2001 17:09:35 -0500
Received: from bitmover.com ([192.132.92.2]:22184 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S286794AbRL2WJP>;
	Sat, 29 Dec 2001 17:09:15 -0500
Date: Sat, 29 Dec 2001 14:09:14 -0800
From: Larry McVoy <lm@bitmover.com>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: The direction linux is taking
Message-ID: <20011229140914.B13883@work.bitmover.com>
Mail-Followup-To: Oliver Xymoron <oxymoron@waste.org>,
	Larry McVoy <lm@bitmover.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20011229120451.E19306@work.bitmover.com> <Pine.LNX.4.43.0112291410080.18183-100000@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.43.0112291410080.18183-100000@waste.org>; from oxymoron@waste.org on Sat, Dec 29, 2001 at 02:30:36PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29, 2001 at 02:30:36PM -0600, Oliver Xymoron wrote:
> Nonsense. X is a release. At a minimum, a submitted patch should apply to
> the current globally visible kernel release. If you want your patch to
> go in, it has to be current, otherwise no use bothering the
> maintainer. And it ought to compile. 

OK, so this glorious patchbot is going to make sure that a patch patches
cleanly against a known version and compiles.  And that buys me exactly
what?  Not a heck of a lot.  Especially since, as is obvious, if you send
in stuff that doesn't compile consistently, your patches are likely to go
to the back of the line or just get dropped.

> The purpose of the patchbot is to bounce patches that don't
> apply/compile/meet whatever baseline before Maintainer ever has to look at
> them, thus reducing the 'black hole effect' of the overloaded maintainer.

I'd suggest you go try this idea out.  It's funny how often people suggest
that they are going to make the problems go away, it's always this same
proposal, typically nobody does any work, when they do it doesn't get used,
could it be there is a reason for that?

I'm prepared to be wrong, but I don't hear the maintainers asking for this
patchbot.  Why not?
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
