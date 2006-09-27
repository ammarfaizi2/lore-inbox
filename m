Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbWI0BUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWI0BUV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 21:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWI0BUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 21:20:21 -0400
Received: from main.gmane.org ([80.91.229.2]:17575 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932196AbWI0BUT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 21:20:19 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: The GPL: No shelter for the Linux kernel?
Date: Wed, 27 Sep 2006 01:19:52 +0000 (UTC)
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <slrnehjkf0.757.olecom@deen.upol.cz.local>
References: <MDEHLPKNGKAHNMBLJOLKIEJNOJAB.davids@webmaster.com> <Pine.LNX.4.64.0609221440470.4388@g5.osdl.org> <slrnehaksq.3qb.olecom@deen.upol.cz.local> <Pine.LNX.4.64.0609230941530.4388@g5.osdl.org> <slrnehb8ch.9ia.olecom@deen.upol.cz.local>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 158.194.64.175
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Sorry for errors with CC, and ugly forwarded message                   ]
[ <slrnehb8ch.9ia.olecom@deen.upol.cz.local>, refs had have to be added. ]

Linus,

On Sat, Sep 23, 2006 at 10:03:49AM -0700, Linus Torvalds wrote:
> 
> 
> On Sat, 23 Sep 2006, Oleg Verych wrote:
> 
> > 
> > On 2006-09-22, Linus Torvalds <torvalds@osdl.org> wrote:
> > >
> > > I don't actually want people to need to trust anybody - and that very much 
> > > includes me - implicitly.
> > >
> > > I think people can generally trust me, but they can trust me exactly 
> > > because they know they don't _have_ to.
> > 
> > And somebody chooses anoter license, f.e see:
> > linux/drivers/video/aty/radeon_base.c
> 
> We have always (and will continue to do so) accepted licenses that are 
> compatible with the GPLv2 for the kernel. 

just wanted to point that comment about your PETv2.

[...]
> > > just picked the first screenful of people (and Alan. And later we added 
> > > three more people after somebody pointed out that some top people use 
> > 
> > Alan *is on top* of (old fashioned, gitless):
> > 
> > $ for i in `find linux/drivers/`
> > do dd count=1 <$i | grep @ | sed 's_[^<]*<\(.*@.*\)>[^>]*_\1_g'
> > done | sort | uniq -c | sort -rn | most
> 
> Well, quite frankly, I don't think the copyright messages in the source 
> code is necessarily very good. Some people add them, most don't. 

This is a surprise for me; big IT companies' time ?
I know about per-contribution mark-credit via sign-off, you've talked
about, but initial creating of big chunk must and, as i can see, have all that
copyrights, even from guys from big IT. It seems, that you don't care
much. Well, in case of mr. Alan Cox i do care.

> 
> But yes, for obvious reasons Alan was added _regardless_ of any counts.
> 
> > And what about linux/CREDITS ? Creating (even in the past) is also worth.
> 
> And what about the old history from BK time? And what about a million 

where's BK, and where is the kernel ?
I'm even glad to have hard proof inside of current kernel. After many
years, great job is hard to hide. For example, even nowdays ac patchset is
positively commented (some days ago i've read Russell's message about arm
tree maintainig).

> 
> Btw, if it makes you feel any better, if you look at the old 
> linux-historic archive (which goes back another 3+ years), and do the same 

Still big IT time,

> statistics, it's quite impressive how similar the list would be (Alan 
> _did_ show up on that list on his own, btw).

i thought about 5-10 years ago, actually.  

> So I claim that my list of people is one of the better lists you can come 
> up with. 

"if it makes you feel any better" ;D

The Free Software Foundation have only toolchain as big GPLv2 product.
But it has LGPL parts. Functionality implemented in libraries, thus
GPL itself applies to small (mostly sf.net dead) pieces of application.

The Linux Kernel is pure GPL.
(all boiler-plate license blobs or binary blobs do not mater)

Thus, i think, FSF just will not have anything without it. And i don't
know why rms started all that...


-o--=O`C  /. .\  (i want ...) (+)
 #oo'L O      o                |
<___=E M    ^--                | (you're barking up the wrong tree)...

