Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbWITRdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWITRdt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 13:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbWITRdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 13:33:49 -0400
Received: from vms048pub.verizon.net ([206.46.252.48]:62460 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S932120AbWITRds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 13:33:48 -0400
Date: Wed, 20 Sep 2006 13:33:30 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: 2.6.18-rt1
In-reply-to: <20060920165846.GA31522@elte.hu>
To: linux-kernel@vger.kernel.org
Message-id: <200609201333.30532.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20060920141907.GA30765@elte.hu>
 <200609201250.03750.gene.heskett@verizon.net> <20060920165846.GA31522@elte.hu>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 September 2006 12:58, Ingo Molnar wrote:
>* Gene Heskett <gene.heskett@verizon.net> wrote:
>>   LD      .tmp_vmlinux1
>>
>> kernel/built-in.o(.text+0x16f25): In function `hrtimer_start':
>> : undefined reference to `hrtimer_update_timer_prio'
>>
>> make: *** [.tmp_vmlinux1] Error 1
>
>yeah, the !hrt build broke in the last minute, i've uploaded -rt2 with
>the fix.
>
> Ingo
Link?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
