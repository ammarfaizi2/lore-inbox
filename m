Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265575AbRGKTBp>; Wed, 11 Jul 2001 15:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265005AbRGKTBf>; Wed, 11 Jul 2001 15:01:35 -0400
Received: from [208.187.172.194] ([208.187.172.194]:12300 "HELO
	odin.oce.srci.oce.int") by vger.kernel.org with SMTP
	id <S265024AbRGKTBa>; Wed, 11 Jul 2001 15:01:30 -0400
Message-ID: <3B4CA207.8000600@srci.iwpsd.org>
Date: Wed, 11 Jul 2001 12:59:19 -0600
From: "Joshua M. Schmidlkofer" <menion@srci.iwpsd.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2+) Gecko/20010710
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Joshua M. Schmidlkofer" <menion@srci.iwpsd.org>,
        Linux kernel Development Mailing List 
	<linux-kernel@vger.kernel.org>
Subject: Re: 2.4.6-preX, 2.4.6...
In-Reply-To: <3B4B1AFB.1090506@srci.iwpsd.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just to clear up confusion.

  No my system does _not_ complete booting, and no this is NOT an X 
problem!   I just have a dead screen about .5 seconds into the boot 
process.....


thanks,


Joshua M. Schmidlkofer wrote:

> I have a strange problem, and I browsed the archives, but I don't see 
> it being reported.  [God, what's the point.?  It's probably far too 
> ambiguous to be useful.]
>
> My System
> HP Vectra VL8, 128 Ram, pIII 500, Matrox G200 [embedded], 2 Twelve-gig 
> IDE drives.
> Redhat 7.1 [Although, I don't think it matters]
>
> I am using 'kgcc' [a.k.a. egcs-2.91.66] for compiling the kernel.
>
> I have not located exactly [in which patch] the problem began, but if 
> try to boot w/2.4.6-preX - 2.4.6,  the video goes away. And then it 
> seems to lock up the computer.   At first I had APGART + DRI + 
> MatroxFB.  So I removed the FB drivers, and tried again.   Same 
> problems.   So I modularized Agpart, and DRI, [I need them for my X 
> config].  No Change.  Almost immediatly after 'Uncompressing 
> Linux.....'   I see a rush of the text across the screen, and then the 
> screen flashes, and blinks, and then nothing.   I do not even have a  
> chance to see anything at all. 
> I can't tell what's locking up, I tried a SysRQ, but got nothing.   No 
> screen. *sigh*   I am not equiped to do this over a serial or parallel 
> port.   I was hoping that someone would have a clue. 
> In the mean time, I am expirimenting with different things. [kernel 
> config's]   I will try to narrow it to a pre-release from 6.
>
>
> thanks,
>   Joshua
> 2.4.6.config.bz2
>
> Content-Type:
>
> application/octet-stream
> Content-Encoding:
>
> base64
>
>



