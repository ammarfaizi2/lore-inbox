Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313442AbSC2Nzj>; Fri, 29 Mar 2002 08:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313443AbSC2Nz3>; Fri, 29 Mar 2002 08:55:29 -0500
Received: from [195.63.194.11] ([195.63.194.11]:39441 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313442AbSC2NzS>; Fri, 29 Mar 2002 08:55:18 -0500
Message-ID: <3CA471E6.8070506@evision-ventures.com>
Date: Fri, 29 Mar 2002 14:53:42 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cam.ac.uk>
CC: Vojtech Pavlik <vojtech@suse.cz>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.7 IDE 26
In-Reply-To: <3CA2E282.7070906@evision-ventures.com> <Pine.LNX.4.33.0203181243210.10517-100000@penguin.transmeta.com> <3CA2E282.7070906@evision-ventures.com> <5.1.0.14.2.20020328205406.00aec720@pop.cus.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:
> At 20:34 28/03/02, Vojtech Pavlik wrote:
> 
>> On Thu, Mar 28, 2002 at 10:29:38AM +0100, Martin Dalecki wrote:
>> > Wed Mar 20 23:17:06 CET 2002 ide-clean-26
>> >
>> > - Mark all members of structures, which get jiffies assigned or 
>> involved in
>> >    ugly timeout calculations with the prefix PADAM_  for easy 
>> spotting. This is
>> >    Polish for "I'm falling down" or "This brings me to the knees" or 
>> slag
>> >    comment for "What a sh..". Please be assured that it doesn't 
>> sound vulgar.
>>
>> In Czech, too. :)
> 
> 
> <AOL> In Bulgarian, too. (-: </AOL>
> 
> And same in <place your favourite slavic eastern european language here>...

I hope it's clear that the intention is to replace them
by proper timeout handler callbacks.

