Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317308AbSGOEGm>; Mon, 15 Jul 2002 00:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317309AbSGOEGl>; Mon, 15 Jul 2002 00:06:41 -0400
Received: from adsl-216-62-200-99.dsl.austtx.swbell.net ([216.62.200.99]:60074
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S317308AbSGOEGl>; Mon, 15 Jul 2002 00:06:41 -0400
Subject: Re: Future of Kernel tree 2.0 ............
From: Austin Gonyou <austin@digitalroadkill.net>
To: David Weinehall <tao@acc.umu.se>
Cc: c0330 <c0330@yingwa.edu.hk>, linux-kernel@vger.kernel.org
In-Reply-To: <20020713234920.GP29001@khan.acc.umu.se>
References: <E17TUXf-0000Ow-00@ited.yingwa.edu.hk>
	 <1026577702.24686.3.camel@UberGeek>
	  <20020713234920.GP29001@khan.acc.umu.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 14 Jul 2002 23:07:51 -0500
Message-Id: <1026706071.10084.6.camel@UberGeek>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-07-13 at 18:49, David Weinehall wrote:
> On Sat, Jul 13, 2002 at 11:28:22AM -0500, Austin Gonyou wrote:
> > I'd imagine that it would, JMHO, but it makes little sense, at least for
> > prime-time level maintenance of a kernel who's architecture, while valid
> > for use in many areas, is still far limited, even in light of 2.4. 
> 
> The maintenance of the 2.0-tree will continue. I see no point in
> ceasing to maintain it just because the release of 2.6. They simply do
> not target the same audience.

Agreed. Which is why, for the most part I noted that prime-time level
maintenance will not be the norm. Though *someone* I'm sure *will*
maintain it, even if they're the last person using it on the planet.
>From what I understand, a lot of people target 2.0 for embedded anyway.
While 2.2 and 2.4 are usually after thoughts in that arena. *not all,
but most it seems*

> > The advancements which 2.6 will bring, over 2.4, will be extraordinarily
> > different, in terms of overall architecture it seems. Even if it's only
> > a 20% architecture difference from 2.4, think of how much further from
> > 2.0 that is. 
> 
> Yes, and that is why 2.0 is still maintained; for some users, the step
> between 2.0 and a later release is too large when it comes to how many
> userland programs that need to be upgraded/retested/rewritten.

That's true, but in my mind, except for embedded, these same users could
stand to probably upgrade their hardware as well, not just for speed
improvements, but capacity, and capability. This would most likely force
them into a new kernel to *properly* support newer hardware, or take
advantage of advancements that 2.0 can't offer.

> Really, there is little reason to worry; my contribution to the
> development of 2.5 (and a forthcoming 2.6/2.7/2.8/...) would probably
> not be much larger were I to drop maintenance of the 2.0-tree. Possibly,
> Marcello and Linus would receive a few more odd fixes for typos and
> the Config-files, and maybe some MCA-related fixes, but as things stand
> right now, the fact that I only have a dialup-connection stands between
> me and serious development (<subliminal message>anyone care to sponsor a
> faster connection or hire me?</subliminal message>)

I do agree with that as well. I don't see any reason to worry. It's
open-source, and the codebase will always be available, in *someone's*
repository at least.

> 
> Regards: David Weinehall
>   _                                                                 _
>  // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
> //  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
> \>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Austin Gonyou <austin@digitalroadkill.net>
