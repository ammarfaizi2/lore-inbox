Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263097AbVCDXwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263097AbVCDXwR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 18:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263178AbVCDXsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:48:22 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:16381 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S263099AbVCDW3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 17:29:32 -0500
Date: Fri, 04 Mar 2005 17:29:24 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: RFD: Kernel release numbering
In-reply-to: <Pine.LNX.4.58.0503041230020.11349@ppc970.osdl.org>
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizon.net
Message-id: <200503041729.24942.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
 <4228B514.4020704@keyaccess.nl>
 <Pine.LNX.4.58.0503041230020.11349@ppc970.osdl.org>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 March 2005 15:37, Linus Torvalds wrote:
[...]
>No.
>
>I used to do "-pre", a long time ago. Exactly because they were
>synchronization points for developers.
>
>These days, that's pointless. We keep the tree in pretty good
> working order (certainly as good as my -pre's ever were)
> constantly, and developers who need to can synchronize with either
> the BK tree or the nightly snapshots. The fact is, 99% of the
> developers don't even need to do that, since most of the
> development process is quite well parallellised by now, and there
> is seldom any serious overlap.

And I think your use of bitkeeper is largely responsible for that.

>So the point of -pre's are gone. Have people actually _looked_ at
> the -rc releases? They are very much done when I reach the point
> and say "ok, let's calm down". The first one is usually pretty big
> and often needs some fixing, simply because the first one is
> _inevitably_ (and by design) the one that gets the pent-up demand
> from the previous calming down period.
>
>But it's very much a call to "ok, guys, calm down now".
>
>And if you aren't calming down, it's _your_ problem. Complaining
> about naming of -pre vs -rc is pointless.
>
>The even/odd situation would have made for a situation that some
> people seem to be arguing for (more explicit calming-down period),
> but with the difference that I think the odd ones should definitely
> have been user-release quality already. But that one was apparently
> hated by so many people that it's not even worth trying.
>
>The fact is, there is no perfect way of doing things, and this
> discussion has degenerated into nothing but whining. Which is kind
> of expected, but let's hope that the only non-whining that came out
> of this (Greg & co's trials with 2.6.x.y) ends up being worthwhile.
>
>  Linus
One last Q I guess.  When was the last time somebody flushed a bug out 
of forcedeth?  I built a kernel last night after turning off the 
broken flag, and when I rebooted to it this morning I was surprised 
to see that because its still marked experimental, I had no 
networking.  And when I went to turn that back on, I also had to go 
turn that back on seperately.

IMO, no usefull purpose is achieved by keeping it experimental after 
the amount of time thats gone by with 1/4 of the world whose mobo has 
an NForce2 chipset on it, using that as their networking driver.

My $0.02.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
