Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286465AbRL0Shs>; Thu, 27 Dec 2001 13:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286462AbRL0Shi>; Thu, 27 Dec 2001 13:37:38 -0500
Received: from ns.suse.de ([213.95.15.193]:20484 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S286455AbRL0ShW>;
	Thu, 27 Dec 2001 13:37:22 -0500
Date: Thu, 27 Dec 2001 19:37:16 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: The direction linux is taking
In-Reply-To: <a0fntk$ukm$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0112271928260.15706-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Dec 2001, Linus Torvalds wrote:

> This is absolutely true - it's a _very_ powerful thing. Old patches
> simply grow stale: keeping track of them is not necessarily at all
> useful, and can add more work than anything else.

*nod*, until they get scooped up into another tree -ac, -dj, -whatever
and fed to you whenever you're in the mood for resyncing.

> This is not about technology.  This is about sustainable development.
> The most important part to that is the developers themselves - I refuse
> to put myself in a situation where _I_ need to scale, because that would
> be stupid - people simply do not scale.  So I require others to do more
> of the work. Think distributed development.

Absolutely. When I decided to take on carrying the 2.4 patches in sync
with 2.5, I knew I was undertaking something of no small order.
Scooping up forward port patches, and silent-drop bits from l-k
is almost a full time job in itself when yourself and Marcelo release
kernels in quick succession 8-)

And when you're ready to resync what I've got so far (currently ~3mb),
it's going to be another full time job splitting it into bits to feed
you linus-bite-sized chunks. (ObSidenote: When this time comes btw,
if maintainers of relevant parts want to feed Linus their relevant
parts from my tree, that would be appreciated, and would keep _my_ load
down :-)

> We've seen this several times in Linux - David, for example, used to
> maintain his CVS tree, and he ended up being rather frustrated about
> having to then maintain it all and clean up the bad parts because I
> didn't want to apply them (and he didn't really want me to) and he
> couldn't make people clean up themselves because "once it was in, it was
> in".

"Used to" ? cvs @ vger.samba.org was still being maintained before
I went on xmas vacation. Did I miss something ?

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

