Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313765AbSEASBg>; Wed, 1 May 2002 14:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313767AbSEASBf>; Wed, 1 May 2002 14:01:35 -0400
Received: from [195.63.194.11] ([195.63.194.11]:13572 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313765AbSEASBe>; Wed, 1 May 2002 14:01:34 -0400
Message-ID: <3CD01EC9.3030606@evision-ventures.com>
Date: Wed, 01 May 2002 18:58:49 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Xavier Bestel <xavier.bestel@free.fr>
CC: Erik Steffl <steffl@bigfoot.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide <-> via VT82C693A/694x problems?
In-Reply-To: <Pine.LNX.4.10.10204301754310.2107-100000@master.linux-ide.org>	 <3CCF4BFD.6C7F67EB@bigfoot.com> <1020239797.10097.68.camel@nomade>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Xavier Bestel napisa?:
> Le mer 01/05/2002 à 03:59, Erik Steffl a écrit :
> 
>>  the MB uses via chips so I included via82cxxx driver (as a module). is
>>that correct?
>>
>>  however, I just checked and via82cxxx is NOT loaded. What do I need to
>>do to make ide driver is using via82cxxx module?
>>
>>  I have ide driver compiled in (booting from ide hd), does via82cxxx
>>have to be compiled in?

It has to be compiled in.

