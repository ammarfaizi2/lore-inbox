Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263098AbVCKCE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263098AbVCKCE0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 21:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263090AbVCKCE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 21:04:26 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:42146 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S263257AbVCKCCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 21:02:45 -0500
Date: Thu, 10 Mar 2005 21:02:44 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: 2.6.11 low latency audio test results
In-reply-to: <1110491577.14297.19.camel@mindpipe>
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizon.net
Message-id: <200503102102.44479.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <1110324852.6510.11.camel@mindpipe> <422F07C2.7080900@cybsft.com>
 <1110491577.14297.19.camel@mindpipe>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 March 2005 16:52, Lee Revell wrote:
>On Wed, 2005-03-09 at 08:27 -0600, K.R. Foley wrote:
>> Lee Revell wrote:
>> > Of course all of the above settings provide flawless xrun-free
>> > performance with 2.6.11-rc4 + PREEMPT_RT.
>>
>> The above mentioned patch will apply (and build and run) just fine
>> to 2.6.11 if you fix the EXTRAVERSION portion of the patch to not
>> expect -rc4.
>
>Right, it sure does.  No rejects except the Makefile.
>
>Looks like the release candidate process is getting tighter.
>
>Lee
>
Maybe Lee, maybe.  It kills tvtime, I built that into 2.6.11.2 
yesterday to test.  So I'm back in 2.6.11.2 with only the 
bk-ieee1394.patch applied over the .1 and .2 patches.
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
