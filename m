Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281665AbRKQBFZ>; Fri, 16 Nov 2001 20:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281666AbRKQBFP>; Fri, 16 Nov 2001 20:05:15 -0500
Received: from as4-1-7.has.s.bonet.se ([217.215.31.238]:57756 "EHLO
	k-7.stesmi.com") by vger.kernel.org with ESMTP id <S281665AbRKQBE5>;
	Fri, 16 Nov 2001 20:04:57 -0500
Message-ID: <3BF5B7E5.3040708@stesmi.com>
Date: Sat, 17 Nov 2001 02:05:41 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] AMD SMP capability sanity checking.
In-Reply-To: <Pine.LNX.4.30.0111170044170.32578-100000@Appserv.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

>>Ok, since you're misunderstanding me, where do I find out which is
>>which, ie CPUID 660 is an ... and CPUID 670 is an ...
>>
> 
> Ah, gotcha. Not sure off hand of any resource.
> My x86info program has them documented in source form..
> ftp://ftp.suse.com/pub/people/davej/x86info/


Good enough for me.

> I'll extrapolate those into a human readable table, and put
> it on my webpage sometime..  I've been meaning to put up
> x86info dumps from various cpu's on there actually.
> (I'll take this opportunity to ask anyone with a few spare
> minutes to send -a output to me (NOT to linux-kernel btw))
> 
> 
>>Point me to some good place to find out and I'm happy.
>>
> 
> If you want to look at that source, its in AMD/identify.c
> The last released version isn't aware of MP/XP's, but has the
> earlier models covered.

Umm. Tell me I'm wrong, but didn't your patch say the 670 was ok for SMP ?

The SMP according to your program is a Duron (Morgan Core).

So the Morgon Duron is ok for SMP and the Palomino AthlonXP is not ?

*bashes hand against head*

// Stefan


