Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262573AbVCVJAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262573AbVCVJAl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 04:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262576AbVCVJAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 04:00:41 -0500
Received: from 182.reserved.callplus.net.nz ([203.184.23.182]:52746 "EHLO
	brick.flying-brick.caverock.net.nz") by vger.kernel.org with ESMTP
	id S262573AbVCVJA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 04:00:28 -0500
Date: Tue, 22 Mar 2005 21:00:14 +1200
From: viking <viking@flying-brick.caverock.net.nz>
To: linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050322090014.GA19055@flying-brick.caverock.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus wrote (back on 4th March):
:The even/odd situation would have made for a situation that some people
:seem to be arguing for (more explicit calming-down period), but with the
:difference that I think the odd ones should definitely have been
:user-release quality already. But that one was apparently hated by so many
:people that it's not even worth trying.

:The fact is, there is no perfect way of doing things, and this discussion 
:has degenerated into nothing but whining. Which is kind of expected, but 
:let's hope that the only non-whining that came out of this (Greg &nbsp;co's 
:trials with 2.6.x.y) ends up being worthwhile.

I'm sorry I didn't get to read this earlier. I apologise for stepping in here,
not being a core developer, however, this is what I tend to think about kernel
releases.

Even/odd at the next level down would confuse p.o.u like me. We kind of
grasped that 2.4 was okay to run (generally, anyone remember 2.4.12?) but a
walk with 2.5 was definitely taking your hard drive for a walk. When 2.6 came
along as the new devel kernel (as I perceived everyone saying) I got confused,
then decided to wait to see what happened. It ended up looking like I would
hawe perceived a true 2.6 tree to be - mostly stable, yet a few nice features
being added. The MAJOR difference for me was that there WASN'T a 2.7 feeding
nice stuff to the 2.6 tree - it was all going in directly. Nice.

The new 2.6.x.y has turned out to be an interesting change for me, being
previously used to 2.x.y. I'm guessing the reason for this is that Greg
decided to be a little more fine-grained with releases, so as to reduce
(somewhat) the major jump from 2.6.x to 2.6.x+1 for the developers, who
internally went through 2.6.x+1-rc[123...], and 2.6.x+1-pre[n].

Frankly, I wasn't seeing the major jump, and was thinking of it as perhaps a
few bugs found each time, maybe a couple of fixes, and by the time you'd gone
from 2.6.4 (for example) to 2.6.12, or maybe even 2.6.19, lots of new features
were added, and 98% of the bugs shaken out. So much for the view of a simple
desktop user.

I'm finding the finer granularity a little confusing, as I'm not sure if the
patches are cumulative (not the case in the past for patches on a Linus
kernel) or I just happen to hit a couple of weird patches. Going from 2.6.11.2
to .3, I was told I had seemingly applied one of the patches already, and it
was the same when going from .3 to .4 - not many failures, usually only one or
two.

I like 2.6.  I don't think any of my machines will ever go back to 2.4 (except
perhaps for my wife's machine, but that's another matter <grin>), I like using
it. 

And next time, I won't wait for 20 days before making a comment. Hopefully.

-- 
 /|   _,.:*^*:.,   |\  Cheers from the Viking family, including Pippin, our cat
| |_/'  viking@ `\_| |
|    flying-brick    | $FunnyMail   : What do you mean, I've lost the plot?
 \_.caverock.net.nz_/     5.40      : I planted them carrots right here!!
