Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293680AbSEVKtq>; Wed, 22 May 2002 06:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310835AbSEVKtp>; Wed, 22 May 2002 06:49:45 -0400
Received: from [195.63.194.11] ([195.63.194.11]:9746 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S293680AbSEVKto>;
	Wed, 22 May 2002 06:49:44 -0400
Message-ID: <3CEB68ED.4000804@evision-ventures.com>
Date: Wed, 22 May 2002 11:46:21 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.17 /dev/ports
In-Reply-To: <Pine.LNX.4.44.0205202211040.949-100000@home.transmeta.com>	<3CEB5F75.4000009@evision-ventures.com> <15595.30247.263661.42035@argo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Paul Mackerras napisa?:
> Martin Dalecki writes:
> 
> 
>>Remove support for /dev/port altogether.
> 
> 
> Great idea!

I learned already that PPC people hate outb() and inb() :-).


