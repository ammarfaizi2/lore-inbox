Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315463AbSGMXqs>; Sat, 13 Jul 2002 19:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315468AbSGMXqr>; Sat, 13 Jul 2002 19:46:47 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:48566 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S315463AbSGMXqq>;
	Sat, 13 Jul 2002 19:46:46 -0400
Date: Sun, 14 Jul 2002 01:49:20 +0200
From: David Weinehall <tao@acc.umu.se>
To: Austin Gonyou <austin@digitalroadkill.net>
Cc: c0330 <c0330@yingwa.edu.hk>, linux-kernel@vger.kernel.org
Subject: Re: Future of Kernel tree 2.0 ............
Message-ID: <20020713234920.GP29001@khan.acc.umu.se>
References: <E17TUXf-0000Ow-00@ited.yingwa.edu.hk> <1026577702.24686.3.camel@UberGeek>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1026577702.24686.3.camel@UberGeek>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 13, 2002 at 11:28:22AM -0500, Austin Gonyou wrote:
> I'd imagine that it would, JMHO, but it makes little sense, at least for
> prime-time level maintenance of a kernel who's architecture, while valid
> for use in many areas, is still far limited, even in light of 2.4. 

The maintenance of the 2.0-tree will continue. I see no point in
ceasing to maintain it just because the release of 2.6. They simply do
not target the same audience.

> The advancements which 2.6 will bring, over 2.4, will be extraordinarily
> different, in terms of overall architecture it seems. Even if it's only
> a 20% architecture difference from 2.4, think of how much further from
> 2.0 that is. 

Yes, and that is why 2.0 is still maintained; for some users, the step
between 2.0 and a later release is too large when it comes to how many
userland programs that need to be upgraded/retested/rewritten.

Really, there is little reason to worry; my contribution to the
development of 2.5 (and a forthcoming 2.6/2.7/2.8/...) would probably
not be much larger were I to drop maintenance of the 2.0-tree. Possibly,
Marcello and Linus would receive a few more odd fixes for typos and
the Config-files, and maybe some MCA-related fixes, but as things stand
right now, the fact that I only have a dialup-connection stands between
me and serious development (<subliminal message>anyone care to sponsor a
faster connection or hire me?</subliminal message>)


Regards: David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
