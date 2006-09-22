Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964842AbWIVSB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbWIVSB6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 14:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964845AbWIVSB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 14:01:58 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:42302 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964842AbWIVSB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 14:01:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=JunT3kBqz40JC/+OA0olHSFI23dvEtkVhMt6iwEUKzGPtJTKo0NIsqHavYSQ67nWfkhZAHervvftrPM+V8Q39UvFIPV17qAfjYoi03QOi6Ca6u0m7q93OJd1xXpiC4SssbIu4ijiBJIXJF0ldBNV0nxapDo6l1BD0bPw84SS3vI=
Message-ID: <4514250E.2090100@gmail.com>
Date: Fri, 22 Sep 2006 22:01:50 +0400
From: Manu Abraham <abraham.manu@gmail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: The GPL: No shelter for the Linux kernel?
References: <1158941750.3445.31.camel@mulgrave.il.steeleye.com> <20060922174953.GD9693@stusta.de>
In-Reply-To: <20060922174953.GD9693@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Fri, Sep 22, 2006 at 11:15:50AM -0500, James Bottomley wrote:
> 
>> Although this white paper was discussed amongst the full group of kernel
>> developers who participated in the informal poll, as you can expect from
>> Linux Kernel Developers, there was a wide crossection of opinion.  This
>> document is really only for discussion, and represents only the views of
>> the people listed as authors (not the full voting pool).
>>
>> James
>>
>> ----------
>>
>> The Dangers and Problems with GPLv3
>>
>>
>> James E.J. Bottomley             Mauro Carvalho Chehab
>> Thomas Gleixner            Christoph Hellwig           Dave Jones
>> Greg Kroah-Hartman              Tony Luck           Andrew Morton
>> Trond Myklebust             David Woodhouse
>> ...
>> 6 Conclusions
>>
>> ... Therefore, as far as we are
>> concerned (and insofar as we control subsystems of the kernel) we cannot
>> foresee any drafts of GPLv3 coming out of the current drafting process that
>> would prove acceptable to us as a licence to move the current Linux Kernel
>> to.
>> ...
> 
> 
> Some people might wonder why kernel developers have any business
> discussing the GPLv3 in their positions as kernel developers and why 
> 10 core kernel developers put their names on a document containing this
> statement.
> 
> 
> Isn't all this complete nonsense considering that the COPYING file in 
> the kernel contains the following?
> 
> <--  snip  -->
> 
>  Also note that the only valid version of the GPL as far as the kernel
>  is concerned is _this_ particular version of the license (ie v2, not
>  v2.2 or v3.x or whatever), unless explicitly otherwise stated.
> 
> <--  snip  -->
> 
> 
> Considering that the number of people that contributed to the Linux 
> kernel during the last 15 years might be in the range 5.000-20.000, so 
> asking all contributors to agree with a licence change from GPLv2 to 
> GPLv3 (or any other license) and handling all the cases where 
> contributors do not answer, are not reachable or disagree, and doing 
> this in a way not creating legal issues in any jurisdiction is not a 
> realistic option.
> 

More than that the people who are classified as the top ten are just
MAINTAINERS.
a MAINTAINER collects patches from various people.

So eventually a MAINTAINER is the top most contributor ? this might be
valid in certain cases, but not be applicable in all cases.

> 
> So aren't all discussions about "acceptable to us as a licence to move 
> the current Linux Kernel to" silly since this is anyway not an option?
> 
> 
> In the internal discussions there was one point that changes this 
> pictures, and I would consider it highly immoral to keep it secret since 
> it affects every single contributor to Linux.
> 

ACK. cent per cent

Talking about openness and still closed ?



> 
> Thinking about probably changing the license of the kernel makes sense 
> if you believe the following "nuclear option" is a real option:
> 
>      1. It is a legally tenable and arguable position that the Linux
>         kernel is a work of joint authorship whose legal citus is that
>         of the USA.
>      2. On this basis, a single co-author can cause the kernel to be
>         relicensed.
>      3. To be legally sound, such a co-author would have to be either a
>         current major subsystem maintainer or a demonstrated contributor
>         of a significant proportion of code of the kernel.
> 
> 
> cu
> Adrian
> 

Manu
