Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261675AbULZPyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbULZPyN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 10:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbULZPxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 10:53:22 -0500
Received: from out005pub.verizon.net ([206.46.170.143]:60323 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP id S261680AbULZPuK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 10:50:10 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10 typo in include/linux/netfilter.h
Date: Sun, 26 Dec 2004 10:50:04 -0500
User-Agent: KMail/1.7
Cc: Nick Warne <nick@linicks.net>, "David S. Miller" <davem@davemloft.net>
References: <200412260917.38717.nick@linicks.net> <20041226023200.1bbf594d.davem@davemloft.net> <200412261059.57661.nick@linicks.net>
In-Reply-To: <200412261059.57661.nick@linicks.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412261050.05070.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [151.205.45.252] at Sun, 26 Dec 2004 09:50:05 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 December 2004 05:59, Nick Warne wrote:
>On Sunday 26 December 2004 10:32, David S. Miller wrote:
>> > Line 161
>> >
>> > /* Call setsockopt() */
>> > int nf_setsockopt(struct sock *sk, int pf, int optval, char
>> > __user *opt, int len(;  <-------
>>
>> That doesn't exist in the 2.6.10 sources.  Something is
>> up with the source tree you have.  Lots of people would
>> be complaining if this simplistic error were actually
>> in the real 2.6.10 tree.
>
>Yes, I thought strange, but this is the full tar.bz2 from kernel.org
> - I downloaded this morning about 2 hours ago.
>
>http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.10.tar.bz2
>
>Nick

I've had troubles of that nature when getting the .bz2's in a past 
life, so I normally get the .gz's and have had no reccurances of such 
little gotchas.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.30% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
