Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261420AbVCCC3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbVCCC3r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 21:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbVCCC1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 21:27:14 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:20625 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S261405AbVCCCVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 21:21:14 -0500
Date: Wed, 02 Mar 2005 21:21:07 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: RFD: Kernel release numbering
In-reply-to: <Pine.LNX.4.58.0503021710430.25732@ppc970.osdl.org>
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizon.net
Message-id: <200503022121.07679.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
 <20050303002047.GA10434@kroah.com>
 <Pine.LNX.4.58.0503021710430.25732@ppc970.osdl.org>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 March 2005 20:15, Linus Torvalds wrote:
>On Wed, 2 Mar 2005, Greg KH wrote:
>> I think this statement proves that the current development
>> situation is working quite well.  The nasty breakage and details
>> got worked out in the -mm tree, and then flowed into your tree
>> when they seemed sane.
>
>Actually, the breakage I was talking about got fixed in _my_ tree.
>
>I'd love for the -mm tree to get more testing, but it doesn't.
>
Well, that might change if, when I came crying to the list about 
something thats broken in an -mm release, I wasn't chased off to go 
run a "more stable" release.  Thats occured 2-3 times in the past 
year.

I'll willingly play the canary as long as I don't wind up with a 
totally hosed filesystem.  So far, knock on wood, I've been fairly 
lucky and have not had to do a bare metal recovery from amanda.

>> So, any driver stuff is just fine?  Great, I don't have an issue
>> with your proposal then, as it wouldn't affect me that much :)
>
>I don't know about "any", but yeah.
>
>> I do understand what you are trying to achieve here, people don't
>> really test the -rc releases as much as a "real" 2.6.11 release. 
>> Getting a week of testing and bugfix only type patches to then
>> release a 2.6.12 makes a lot of sense.  For example, see all of
>> the bug reports that came out of the woodwork today on lkml from
>> the 2.6.11 release...
>
>A large part of it is psychological. On the other hand, it may be
> that Neil is right and it would just mean that people wouldn't even
> test the odd releases (..because they want to wait a couple of
> weeks for the even one), so it may not actually end up helping
> much.
>
>The thing is, I _do_ believe the current setup is working reasonably
> well. But I also do know that some people (a fairly small group,
> but anyway) seem to want an extra level of stability - although
> those people seem to not talk so much about "it works" kind of
> stability, but literally a "we can't keep up" kind of stability (ie
> at least a noticeable percentage of that group is not complaining
> about crashes, they are complaining about speed of development).
>
>And I suspect that _anything_ I do won't make those people happy.
>
>		Linus
>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
