Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262094AbTKCX1U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 18:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262181AbTKCX1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 18:27:20 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:65010 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262094AbTKCX1T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 18:27:19 -0500
Message-ID: <3FA6E451.1050508@mvista.com>
Date: Mon, 03 Nov 2003 15:27:13 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Albert Cahalan <albert@users.sourceforge.net>
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       linuxquestasu@yahoo.com
Subject: Re: Cyclic Scheduling for linux
References: <1067646722.2560.259.camel@cube>
In-Reply-To: <1067646722.2560.259.camel@cube>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

He is supposed to do this for a class.  I wonder if the teacher would give extra 
credits for grabbing on open source solution instead of writting the code...

But then you did not say the Concurrent thing was open source. :)

-g

Albert Cahalan wrote:
>>I am working on providing a cyclic scheduling policy
>>to the current non real time version of the linux to
>>support hard real time tasks as part of one of my
>>projects. This policy should be able to support
>>aperiodic, periodic and sporadic tasks too. Could any
>>one pour some light on how to go about achieving it?.
>>
>>Any Helpful tips, project reports, links or advices
>>are greatly appreciated.
> 
> 
> I suppose you expect to write this, but if not,
> you can get it in Concurrent's Red Hawk Linux
> product.
> 
> Marketing says:
> 
> "RedHawk's Frequency-Based Scheduler (FBS) is a
> high-resolution task scheduler that enables the
> user to run processes in cyclical execution patterns.
> FBS can control the periodic execution of multiple,
> coordinated processes utilizing major and minor
> cycles with overrun detection. A performance
> monitor is also provided to view CPU utilization
> during each scheduled execution frame."
> 
> That's on a "real" Linux kernel, not like RTAI
> or RT-Linux. There are some other cool real-time
> features as well, and an Ada compiler if you're
> so inclined.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

