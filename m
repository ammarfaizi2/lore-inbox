Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291192AbSCDDdN>; Sun, 3 Mar 2002 22:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291193AbSCDDcx>; Sun, 3 Mar 2002 22:32:53 -0500
Received: from ip68-3-107-226.ph.ph.cox.net ([68.3.107.226]:31724 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S291192AbSCDDcn>;
	Sun, 3 Mar 2002 22:32:43 -0500
Message-ID: <3C82EAD9.8010802@candelatech.com>
Date: Sun, 03 Mar 2002 20:32:41 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: J Sloan <joe@tmsusa.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: latency & real-time-ness.
In-Reply-To: <E16hd1T-0005QW-00@the-village.bc.nu> <3C82A702.1030803@candelatech.com> <3C82CA19.9000702@tmsusa.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



J Sloan wrote:

> Ben Greear wrote
> 
>>> Would the low-latency patch help me?
>>>
>>> Yes
>> Excellent, I'm compiling that now.... 
> Eh?
> 
> The full-on low latency patch from Andrew Morton?
> 
> You might want to make some diffs available
> since AFIK that would have involved quite a bit
> of hand editing to fix rejects...


I found this patch:
preempt-kernel-rml-2.4.19-pre2-ac2-1.patch

It applied cleanly...looks like maybe this isn't
the low-latency patch though now that I look at
it a little closer.

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


