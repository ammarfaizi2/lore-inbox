Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbUBWA3n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 19:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbUBWA3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 19:29:43 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:35333 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S261291AbUBWA3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 19:29:41 -0500
Message-ID: <40394BA3.4070307@techsource.com>
Date: Sun, 22 Feb 2004 19:38:59 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Scott Robert Ladd <coyote@coyotegulch.com>
CC: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Intel vs AMD x86-64
References: <Pine.LNX.4.58.0402171739020.2686@home.osdl.org> <16435.14044.182718.134404@alkaid.it.uu.se> <Pine.LNX.4.58.0402180744440.2686@home.osdl.org> <20040222025957.GA31813@MAIL.13thfloor.at> <Pine.LNX.4.58.0402211907100.3301@ppc970.osdl.org> <40382C47.70603@coyotegulch.com>
In-Reply-To: <40382C47.70603@coyotegulch.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Scott Robert Ladd wrote:
> Linus Torvalds wrote:
> 
>> Any Intel people on this list: tell your managers to be f*cking 
>> ashamed of
>> themselves. Just because Intel didn't care about their customers and has
>> been playing with some other 64-bit architecture that nobody wanted to 
>> use
>> is no excuse for not giving credit to AMD for what they did with x86-64.
>>
>> (I'm really happy Intel finally got with the program, but it's pretty 
>> petty to not even mention AMD in the documentation and try to make it 
>> look like it was all their idea).
> 
> 
> I couldn't have put it better myself. Were it polite to attach sounds to 
> mailing list posts, I would add thunderous applause to my approbations.
> 
> Intel chips have been a part of my professional life for a very long 
> time; I've never owned an AMD processor, and I'm certainly not one of 
> their fanboys. I've worked closely with folk at Intel on some projects, 
> and they have been quite generous at times. Some fine technologists work 
> for them.
> 
> But on a corporate level, Intel has disappointed me with their arrogant 
> failure to give credit where credit is due.
> 
> Last week, before Intel's announcement, I ordered a new Linux 
> workstation. As a "lone wolf" consultant, I sometimes agonize over 
> whether I make the right decisions when buying equipment. In this case, 
> I feeling pretty dang good: the new system will arrive with a pair of 
> Opterons on the motherboard.
> 

I don't know how accurate this information is, but... (take it with a 
grain of salt)

I have a good friend who worked at a lab where a lot of scientific 
simulations were being done.  Lots of floating-point math.  His 
colleagues tried both AMD and Intel processors.  According to this 
friend, what they found was that not only were the AMD processors FASTER 
at FP math, but the results they got were also a lot more ACCURATE when 
dealing with computations at the far end of FP precision.

In theory, IEEE FP is IEEE FP, but it seems that Intel may have cheated 
in their design, silently reducing precision for the sake of some other 
aspect of their design, making their processors less useful (or 
useless?) for scientific applications.  Another example of Intel 
arrogance?  Or perhaps a reasonable design compromise?  You decide.


