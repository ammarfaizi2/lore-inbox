Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbVH3Sum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbVH3Sum (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 14:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbVH3Sum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 14:50:42 -0400
Received: from nijmegen.renzel.net ([195.243.213.130]:32188 "EHLO
	mx1.renzel.net") by vger.kernel.org with ESMTP id S932262AbVH3Sul
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 14:50:41 -0400
Message-ID: <4314AA1A.4030707@twisted-brains.org>
Date: Tue, 30 Aug 2005 20:48:58 +0200
From: Mws <mws@twisted-brains.org>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
CC: Chase Venters <chase.venters@clientec.com>, linux-kernel@vger.kernel.org
Subject: Re: Second "CPU" of 1-core HyperThreading CPU not found in 2.6.13
References: <88056F38E9E48644A0F562A38C64FB6005950A6F@scsmsx403.amr.corp.intel.com>
In-Reply-To: <88056F38E9E48644A0F562A38C64FB6005950A6F@scsmsx403.amr.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pallipadi, Venkatesh wrote:
>>-----Original Message-----
>>From: linux-kernel-owner@vger.kernel.org 
>>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Chase Venters
>>Sent: Monday, August 29, 2005 9:04 PM
>>To: linux-kernel@vger.kernel.org
>>Subject: Second "CPU" of 1-core HyperThreading CPU not found in 2.6.13
>>
>>Greetings kind hackers...
>>	I recently switched to 2.6.13 on my desktop. I noticed 
>>that the second 
>>"CPU" (is there a better term to use in this HyperThreading 
>>scenario?) that 
>>used to be listed in /proc/cpuinfo is no longer present. 
> 
> 
> Complete 'dmesg' please.
> 
> Thanks,
> Venki
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

just verified.
i have got the same problem here.
p4 asus mainboard most recent bios
prescott cpu
everything is fine for detecting cpu with 2.6.13-rc1
i just tested 2.6.13-rc7 and release today only 1 cpu is shown

regards
marcel

ps. dmesg will follow tomorrow if nothin has reached the ml then.
(i need the machine now compiling some stuff)
