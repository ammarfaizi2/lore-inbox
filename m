Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316185AbSEWHMG>; Thu, 23 May 2002 03:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316216AbSEWHMF>; Thu, 23 May 2002 03:12:05 -0400
Received: from [195.63.194.11] ([195.63.194.11]:29703 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316185AbSEWHME>; Thu, 23 May 2002 03:12:04 -0400
Message-ID: <3CEC8768.1060002@evision-ventures.com>
Date: Thu, 23 May 2002 08:08:40 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.17 IDE 67
In-Reply-To: <3CEB466B.3090604@evision-ventures.com> <20020522171329.GG1209@opus.bloom.county> <3CEBC576.4060703@evision-ventures.com> <20020522173137.GH1209@opus.bloom.county> <3CEBC9EE.2090701@evision-ventures.com> <20020522184722.GB5575@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Tom Rini napisa?:
> On Wed, May 22, 2002 at 06:40:14PM +0200, Martin Dalecki wrote:
> 
>>Uz.ytkownik Tom Rini napisa?:
>>
>>>And when the PPC4xx drivers are ready to be submitted we'll need to add
>>>in __powerpc__ tests too.  Can't we just keep CONFIG_DMA_NONPCI for now?
>>
>>Plese feel free to add them when and where they are needed.
>>It's no problem to clean this all up
>>then again if a true usage pattern emerges.
>>And I have no problem with patches toching "core" driver stuff as long
>>as the changes are justified I will integrate them with pleasure at time.
> 
> 
> Okay. :)
> 
> BTW, maybe it's part of the great IDE rewrite and all, but the
> CONFIG_DMA_NONPCI part of drivers/ide/ide.c didn't get a __CRIS__ added
> back in.

Please look at ide-features.c there is should be there.

