Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbUL1QmD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbUL1QmD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 11:42:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbUL1QmC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 11:42:02 -0500
Received: from mail.tmr.com ([216.238.38.203]:51909 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S261256AbUL1Q10 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 11:27:26 -0500
Message-ID: <41D18BF0.2090400@tmr.com>
Date: Tue, 28 Dec 2004 11:38:08 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Len Brown <len.brown@intel.com>,
       Linux Kernel mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Ho ho ho - Linux v2.6.10 (irq18)
References: <41CE282C.3010606@tmr.com> <1104171962.18174.28.camel@d845pe>
In-Reply-To: <1104171962.18174.28.camel@d845pe>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown wrote:
> On Sat, 2004-12-25 at 21:55, Bill Davidsen wrote:
> 
> 
>>Alas, It sort-of boots but is terminally slow. I see the log with 
>>endless repetitions of "irq 18 nobody cared" and some trace, then 
>>"disabling irq 18." Unfortunately it lies, after about 20MB of this I 
>>decided it had no real intention of disabling irq 18 and tried to stop
>>it. After ten minutes I had to pull the plug and it's still cleaning 
>>filesystems.
> 
> 
> was irq18 ignored (and disabled) in 2.6.9 on this box?
> 
> 
Last 2.6 kernel run was 2.6.7, which didn't have any problem with irq18. 
I'm going to gather the full set of data on acpi= and pci= options, but 
I'm nominally on vacation and spending time with the family instead of 
computers. Also, I can't use my Christmas present until I get the FC1 
kernel to set the i810/ac97 audio to 4 channels instead of the default 
two, so all the people saying "I want to hear it" can't be satisfied.

Priorities this week...

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
