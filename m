Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317281AbSFCFpa>; Mon, 3 Jun 2002 01:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317282AbSFCFp3>; Mon, 3 Jun 2002 01:45:29 -0400
Received: from [195.63.194.11] ([195.63.194.11]:16905 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317281AbSFCFpZ>; Mon, 3 Jun 2002 01:45:25 -0400
Message-ID: <3CFAF4A0.5010702@evision-ventures.com>
Date: Mon, 03 Jun 2002 06:46:24 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Anthony Spinillo <tspinillo@linuxmail.org>, linux-kernel@vger.kernel.org
Subject: Re: INTEL 845G Chipset IDE Quandry
In-Reply-To: <20020602101628.4230.qmail@linuxmail.org> <3CFA73C3.9010902@evision-ventures.com> <20020602233043.A11698@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Sun, Jun 02, 2002 at 09:36:35PM +0200, Martin Dalecki wrote:
> 
>>Anthony Spinillo wrote:
>>
>>>Back to my original problem, will there be a fix before 2010? ;)
>>
>>Well since you have already tyred yourself to poke at it.
>>Well please just go ahead and atd an entry to the table
>>at the end of piix.c which encompasses the device.
>>Do it by copying over the next familiar one and I would
>>be really geald if you could just test whatever this
>>worked. If yes well please send me just the patch and
>>I will include it.
> 
> 
> Note it works with 2.5 already. We have the device there.


Yes after looking it up I realized it's already there.

