Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266550AbUG0SmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266550AbUG0SmK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 14:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266558AbUG0SmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 14:42:10 -0400
Received: from out008pub.verizon.net ([206.46.170.108]:8694 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S266550AbUG0SgY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 14:36:24 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Organization: Organization: undetectable
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2 crashes
Date: Tue, 27 Jul 2004 14:36:23 -0400
User-Agent: KMail/1.6
References: <200407271233.04205.gene.heskett@verizon.net> <200407271402.59846.gene.heskett@verizon.net> <20040727105039.052352d8.rddunlap@osdl.org>
In-Reply-To: <20040727105039.052352d8.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407271436.23097.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [151.205.53.180] at Tue, 27 Jul 2004 13:36:23 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 July 2004 13:50, Randy.Dunlap wrote:
>On Tue, 27 Jul 2004 14:02:59 -0400 Gene Heskett wrote:
>| On Tuesday 27 July 2004 13:32, Randy.Dunlap wrote:
>| [...]
>|
>| Gene Heskett wrote:
>| >| I take it that I should apply these to a 2.6.7 tarballs tree in
>| >| this order:
>| >| 1. 2.6.8-rc1
>| >|
>| >>>>> 2.6.8-rc2 <<<<<
>|
>| 2.6.8-rc2?  These patches I got will need to be reverted then?
>
>Nope, my bad.  I didn't read $Subject... please continue....

Oh, mmm, well, for some unexplainable reason it did apply the patches 
on top of rc2 without any fussing, and it is building, ahh scuse me, 
is built.  This athlon 2800 is awesome, my makeit script runs in a 
bit over 6 minutes.  And unrelated of course, by now, the kde build 
has puked all over itself, it now doesn't like the glibc installed by 
FC2.  Go figure...

Anyway, now I'll go make it again using the 2.6.8-rc1 main patch & 
throw this one away.  Not that big a deal when there a 120Gb drive to 
play in.


>| >| 2. each of these 'rc2-bk' patches by the day and then run each
>| >| for a couple days, or should I start in the middle, say the 3rd
>| >| one and work forward or backwards from there depending on the
>| >| results?
>| >
>| >I'd suggest beginning with -bk3 and doing a binary search.
>|
>| Ok, as soon as the kde build exits (and it will, bet the whole
>| farm on it)  I'll give it a try.
>|
>| >| Your (and Viro's) call.  I'd imagine you would want to run this
>| >| to earth as quick as we can.
>| >|
>| >| Are these patches cumulative?  I presume they are as they grow
>| >| by the day.
>| >
>| >Sorry, I should have mentioned that.  Yes, they are cumulative.
>|
>| Well, it was a pretty obvious conclusion :)
>
>--
>~Randy

-- 
Cheers, Gene
There are 4 boxes to be used in defense of liberty. 
Soap, ballot, jury, and ammo.
Please use in that order, starting now.  -Ed Howdershelt, Author
Additions to this message made by Gene Heskett are Copyright 2004, 
Maurice E. Heskett, all rights reserved.
