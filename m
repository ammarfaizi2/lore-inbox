Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316573AbSEVRnj>; Wed, 22 May 2002 13:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316593AbSEVRni>; Wed, 22 May 2002 13:43:38 -0400
Received: from [195.63.194.11] ([195.63.194.11]:44818 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316573AbSEVRng>; Wed, 22 May 2002 13:43:36 -0400
Message-ID: <3CEBC9EE.2090701@evision-ventures.com>
Date: Wed, 22 May 2002 18:40:14 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.17 IDE 67
In-Reply-To: <3CEB466B.3090604@evision-ventures.com> <20020522171329.GG1209@opus.bloom.county> <3CEBC576.4060703@evision-ventures.com> <20020522173137.GH1209@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Tom Rini napisa?:
>
> And when the PPC4xx drivers are ready to be submitted we'll need to add
> in __powerpc__ tests too.  Can't we just keep CONFIG_DMA_NONPCI for now?
> 

Plese feel free to add them when and where they are needed.
It's no problem to clean this all up
then again if a true usage pattern emerges.
And I have no problem with patches toching "core" driver stuff as long
as the changes are justified I will integrate them with pleasure at time.

In the time between I tend to code for reality and not for vapour
(no offence intendid...) :-).

