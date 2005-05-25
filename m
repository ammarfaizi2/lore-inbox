Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262262AbVEYDjC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262262AbVEYDjC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 23:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbVEYDjC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 23:39:02 -0400
Received: from vms042pub.verizon.net ([206.46.252.42]:38624 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S262257AbVEYDih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 23:38:37 -0400
Date: Tue, 24 May 2005 23:38:33 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: RT patch acceptance
In-reply-to: <1116978384.2912.53.camel@mindpipe>
To: linux-kernel@vger.kernel.org
Message-id: <200505242338.33641.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <001701c560a6$cafbe2b0$c800a8c0@mvista.com>
 <4293AB4D.4030506@opersys.com> <1116978384.2912.53.camel@mindpipe>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 May 2005 19:46, Lee Revell wrote:
>On Tue, 2005-05-24 at 18:31 -0400, Karim Yaghmour wrote:
>> I've taken enough bandwidth as it is
>> on this thread, and I frankly don't think that any of what I
>> said above has added any more information for those who've
>> read my previous postings. I only got into this thread to point
>> out that some info about RTAI was wrong. So like I told Ingo,
>> if rt-preempt gets in, then so be it.
>
>Here's my favorite excerpt:
>
>On Sat, 2004-10-09 at 16:11, Karim Yaghmour wrote:
>> And this has been demonstrated mathematically/algorithmically to
>> be true 100% of the time, regardless of the load and the driver
>> set? IOW, if I was building an automated industrial saw (based on
>> a VP+IRQ-thread kernel or a combination of the above-mentioned
>> agregate) with a safety mechanism that depended on the kernel's
>> responsivness to outside events to avoid bodily harm, would you be
>> willing to put your hand beneath it?
>
>Maybe -RT should be merged when Ingo puts his hand under the saw.
>
>Lee

Off topic sorry, can't resist.

Maybe so Lee, but first we'ed better check with the USTPO, as one of 
the major table saw makers is actually selling a saw that you can 
stick a weiner into while its running, and a common bandaid can cover 
the damage.  The blade is stopped before the next tooth after the one 
that initially contacts the weiner can come around and do more than 
scratch the weiner.  The stop is a bit noisy I assume considering you 
are stopping a blade turning 3k to 6k rpms in 1/4" of linear motion 
at the rim of the blade, and rather expensive, ISTR a $400 option in 
their top of the line 10 inch table saws.  Because of the larger 
components, the 14" saw carries over $1k premium for that option.

>
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
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
