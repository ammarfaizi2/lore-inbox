Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313698AbSFBUfv>; Sun, 2 Jun 2002 16:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314083AbSFBUfu>; Sun, 2 Jun 2002 16:35:50 -0400
Received: from [195.63.194.11] ([195.63.194.11]:58374 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313698AbSFBUfu>; Sun, 2 Jun 2002 16:35:50 -0400
Message-ID: <3CFA73C3.9010902@evision-ventures.com>
Date: Sun, 02 Jun 2002 21:36:35 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Anthony Spinillo <tspinillo@linuxmail.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: INTEL 845G Chipset IDE Quandry
In-Reply-To: <20020602101628.4230.qmail@linuxmail.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anthony Spinillo wrote:
> Back to my original problem, will there be a fix before 2010? ;)

Well since you have already tyred yourself to poke at it.
Well please just go ahead and atd an entry to the table
at the end of piix.c which encompasses the device.
Do it by copying over the next familiar one and I would
be really geald if you could just test whatever this
worked. If yes well please send me just the patch and
I will include it.

> 
> Tony
> 
> 
> Martin Dalecki wrote:
> 
> 
>>Of year 2010 - remember learning proper C will take him time.
>>Becouse I never ever saw any code contributed by him
>>despite the fact that I'm still open for patches, as
>>I have told him upon request.
>>Once exception was a broken patch which even didn't
>>compile and couldn't solve the problem it was
>>proclaiming to solve.
>>
>>
> 
> 



-- 
- phone: +49 214 8656 283
- job:   eVision-Ventures AG, LEV .de (MY OPINIONS ARE MY OWN!)
- langs: de_DE.ISO8859-1, en_US, pl_PL.ISO8859-2, last ressort: ru_RU.KOI8-R

