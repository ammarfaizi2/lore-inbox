Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbVK1PgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbVK1PgH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 10:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbVK1PgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 10:36:05 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:14741 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751275AbVK1PgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 10:36:04 -0500
Date: Mon, 28 Nov 2005 10:35:18 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: saa7134 broken in 2.6.15-rc2
In-reply-to: <438B1F89.7000402@linuxtv.org>
To: linux-kernel@vger.kernel.org
Message-id: <200511281035.18541.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20051128135254.GA4218@wonderland.linux.it>
 <20051128141003.GA4806@wonderland.linux.it> <438B1F89.7000402@linuxtv.org>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 November 2005 10:17, Mike Krufky wrote:
>Marco d'Itri wrote:
>>On Nov 28, Duncan Sands <duncan.sands@math.u-psud.fr> wrote:
>>>here seems to be something rotten in v4l land; here's one I got with
>>> 2.6.15-rc1-git1
>>
>>Yes, I should have STFW better:
>> http://lkml.org/lkml/fancy/2005/11/24/194 .
>>
>>video-buf is still broken for me in -rc2, I can make xawtv work if I
>> set capture to "overlay", but it still complain about no input
>> sources other than "default".
>
>Please try again, using the current -git snapshot.... The memory
>problems have been fixed by Hugh Dickins in 2.6.15-rc2-git3 , and
> Dmitry has submitted some input fixes after that.....
>
>I am running 2.6.15-rc2-git6 with no problems.
>
Whats the patch sequence to arrive at rc2-git6 please?

>If you are still having problems, please let us know, being sure to cc
>the v4l mailing list.
>
>Cheers,
>
>Michael Krufky
>
>
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

