Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750929AbVL3XnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbVL3XnI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 18:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbVL3XnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 18:43:08 -0500
Received: from [202.67.154.148] ([202.67.154.148]:13750 "EHLO ns666.com")
	by vger.kernel.org with ESMTP id S1750929AbVL3XnH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 18:43:07 -0500
Message-ID: <43B5C5F6.5070500@ns666.com>
Date: Sat, 31 Dec 2005 00:42:46 +0100
From: Mark v Wolher <trilight@ns666.com>
User-Agent: Mozilla/4.8 [en] (Windows NT 5.1; U)
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
CC: Lee Revell <rlrevell@joe-job.com>,
       Folkert van Heusden <folkert@vanheusden.com>,
       Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: system keeps freezing once every 24 hours / random apps crashing
References: <43B53EAB.3070800@ns666.com> <1135980690.31111.35.camel@mindpipe> <43B5B1C4.7070501@ns666.com> <200512302311.27125.s0348365@sms.ed.ac.uk>
In-Reply-To: <200512302311.27125.s0348365@sms.ed.ac.uk>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan wrote:
> On Friday 30 December 2005 22:16, Mark v Wolher wrote:
> [snip]
> 
>>>Basically you are asking for help with an unsupported configuration.  In
>>>general people on LKML will be more helpful if you take the time to find
>>>out what the bug reporting guidelines are before posting.
>>>
>>>Lee
>>
>>Thank you for your input, but sometimes thinking out of the box gives a
>>solution instead of hiding behind "guidelines".
> 
> 
> I'm surprised Lee fed you this long, but the cold hard fact of the matter is 
> that you are posting to the Linux kernel mailing lists, and you will comply 
> with these guidelines if you expect help.
> 
> I'm sure the problem might not be with VMWare, but there is absolutely nothing 
> stopping you from switching nvidia with nv, not loading nvidia/vmware 
> modules, then running the TV card doing *something else* for a few hours. If 
> you do not detect lockups, contact VMWare. They will probably do the exact 
> opposite of what Lee has done and suggest non-VMWare parts of the system are 
> at fault.
> 
> However, unlike VMWare or NVIDIA, we can actually debug problems if you use 
> source-available modules. Thinking outside of the box here is irrelevant -- a 
> problem requires logical procedure to gain a solution. Any engineer will tell 
> you the same thing. Ordinarily, this is test, observe, retest, and all Lee is 
> suggesting is that you do *not* load the proprietary modules.
> 
> Try it before responding to this email, so you do not have to write another.
> 

I already switched nvidia for the nv driver in the kernel. Also disabled
by unloading all modules.

You're saying i should then see what happens after doing the above ...
This is exactly what i'm now doing, tvcard is active (tv) and i'm doing
some work as usual. I get the feeling some people consider everyone who
is a bit different in approach as either some newbie or an idiot, well
wake up, sometimes by looking from a different view at a problem it can
be solved. This doesn't mean i don't appreciate the advise of Lee or
yours, i only ask for some patience. It's not like the world is going
under if we don't solve this in an hour with traditional logic. :)

And at this point the system is still working, i'm increasing the load
by making it crush numbers, doing a full virusscan and so on.



