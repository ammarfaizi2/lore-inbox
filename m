Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751387AbVLAAZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbVLAAZU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 19:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbVLAAZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 19:25:20 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:45461 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751387AbVLAAZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 19:25:18 -0500
Date: Wed, 30 Nov 2005 19:24:51 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Gene's pcHDTV 3000 analog problem
In-reply-to: <200511301553.jAUFrSQx026450@p-chan.krl.com>
To: linux-kernel@vger.kernel.org
Cc: Don Koch <aardvark@krl.com>, Michael Krufky <mkrufky@m1k.net>,
       kirk.lapray@gmail.com, video4linux-list@redhat.com, CityK@rogers.com,
       perrye@linuxmail.org
Message-id: <200511301924.52003.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200511282205.jASM5YUI018061@p-chan.krl.com>
 <438D38B3.2050306@m1k.net> <200511301553.jAUFrSQx026450@p-chan.krl.com>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 November 2005 10:53, Don Koch wrote:
>On Wed, 30 Nov 2005 00:29:23 -0500
>
>Michael Krufky wrote:
>> Gene Heskett wrote:
>> >On Tuesday 29 November 2005 20:26, Michael Krufky wrote:
>> >
>> >[...]
>> >
>> >>ll I can think of doing next is to have Gene, Don or Perry do a
>> >>bisection test on our cvs repo.... checking out different cvs
>> >> revisions until we can narrow it down to the day the problem patch
>> >> was applied.
>
>Do we know of a date where the code is known to work.

I assume this is actually a question.  Its one I'm not privy to other
than whats in 2.6.14.3 and earlier works.  As to when that was merged
into the kernel tarballs, I'll let Michael see if he can date it.  And
then we'ed want to look at anything post that merge date, using the
bisect methods suggested.

However, its not going to be started here tonight, I need some sleep,
drank way too much coffee yesterday & didn't sleep last night at all. 
  
>First thing I'd
> like to do is verify that the card works at all.  Remember, I've never
> seen NTSC tuner mode work and don't want to chase a red herring if the
> card is busted.

It should work with a stock 2.6.14.3 build if its going to work I
think, although there may be other factors for cards other than my
pcHDTV-3000.  Michael?

>Thanks,
>-d
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.36% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.

