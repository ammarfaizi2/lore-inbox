Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284584AbRLUOtS>; Fri, 21 Dec 2001 09:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284596AbRLUOtI>; Fri, 21 Dec 2001 09:49:08 -0500
Received: from mout01.kundenserver.de ([195.20.224.132]:62521 "EHLO
	mout01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S284573AbRLUOsz>; Fri, 21 Dec 2001 09:48:55 -0500
User-Agent: Microsoft-Outlook-Express-Macintosh-Edition/5.02.2106
Date: Fri, 21 Dec 2001 15:48:29 +0100
Subject: Re: Changing KB, MB, and GB to KiB, MiB, and GiB in
	Configure.help.
From: Rene Engelhard <mail@rene-engelhard.de>
To: <linux-kernel@vger.kernel.org>
Message-ID: <B8490A4D.4093%mail@rene-engelhard.de>
In-Reply-To: <1008945627.6599.5.camel@localhost.localdomain>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reid Hekman wrote:

> On Fri, 2001-12-21 at 06:50, Rene Engelhard wrote:
>>>> Why? For instance a millibyte/s might be a hearbeat across a LAN every
>>>> hour or so or it might be a control traffic requirement for a deep space
>>>> probe. You might not have an immediate use for the term but it has a
>>>> specific meaning - and certainly isn't "absurd" (see definition on
>>>> http://www.dict.org).
>>> 
>>> So, is it 1/1024 or 1/1000 bytes ?  :-)
>> 
>> 1/1024. Because we are talking about byte.
> 
> What does bytes have to do with anything? Is it
> 1/(2^3 * 10^7) or 1/(2^3 * 2^7)? We're talking about expressing a number
> of "bytes"; terms of the base number system don't have any bearing --
> and that's the problem. RAM and addressing are restricted to expressions

Right.

8 Bit = 1 Byte
1024 Byte = 1 KB
1024 KB = 1 MB
1024 MB ...

So we are talking about that, beacuse the X-Byte is defined as 1024 and not
as 1000 of the previous step.

> in terms of binary numbers, as in 2^10, 2^20, etc. Hard drive
> manufacturers feel it's neccessary to express storage in terms of base
> 10 numbers of bytes, even though a sector is 2^9 bytes. In networking,
> absolute numbers of bits on the wire are whats important. Though for
> some reason telecom engineers have pinned megabit as 1,024,000 bits.
> Experienced CS people can glean the proper definition from context, but
> the terms should really lend themselves to accurate definition all the
> time. If I just say off the cuff that I'm going to send you a megabyte
> of data, do I mean 1,000,000 bytes, 1,048,576 bytes, or 1,024,000 bytes?

What _you_ mean can not be determied from me.
But *I* would mean 1.048.574, otherwise I would say the 9xxx number or say
nearly 1 MB.

> With the new measures those would be a megabyte, a mebibyte, and 1,024
> kilobytes respectively.

That's the sense of them.
 
Rene

