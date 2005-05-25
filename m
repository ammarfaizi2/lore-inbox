Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262315AbVEYNXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262315AbVEYNXb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 09:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbVEYNXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 09:23:31 -0400
Received: from vms042pub.verizon.net ([206.46.252.42]:28609 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S262315AbVEYNVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 09:21:07 -0400
Date: Wed, 25 May 2005 09:20:57 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: RT patch acceptance
In-reply-to: <42940A87.7010504@yahoo.com.au>
To: linux-kernel@vger.kernel.org
Message-id: <200505250920.57389.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <4292DFC3.3060108@yahoo.com.au>
 <200505242326.16929.gene.heskett@verizon.net> <42940A87.7010504@yahoo.com.au>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 May 2005 01:17, Nick Piggin wrote:
>Gene Heskett wrote:
>>On Tuesday 24 May 2005 22:20, Andrew Morton wrote:
>>>Sven Dietrich <sdietrich@mvista.com> wrote:
>>>>I think people would find their system responsiveness /
>>>> tunability goes up tremendously, if you drop just a few
>>>> unimportant IRQs into threads.
>>>
>>>People cannot detect the difference between 1000usec and 50usec
>>>latencies, so they aren't going to notice any changes in
>>>responsiveness at all.
>>
>>Excuse me?
>
>You are excused ;)
>
>> 1 second (1000 usecs, 200 times your 50 usec example) is
>
>1000usecs is 1msec.

Duh, my mistake. And it probably wouldn't do to plead alzheimers 
either, darn.

[...]

>This is a topic that for some reason will tend to degenerate into a
> random shouting match where nobody actually says anything or
> listens to anything, and nothing gets done. Not to say you are
> trying to start a flamewar, Gene, but everyone just needs to tread
> a bit carefully :)

Duely chastised.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
