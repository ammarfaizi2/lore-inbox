Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317137AbSEXPgB>; Fri, 24 May 2002 11:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317144AbSEXPgA>; Fri, 24 May 2002 11:36:00 -0400
Received: from [195.63.194.11] ([195.63.194.11]:57615 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317137AbSEXPf6>; Fri, 24 May 2002 11:35:58 -0400
Message-ID: <3CEE4ECB.5070603@evision-ventures.com>
Date: Fri, 24 May 2002 16:31:39 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Jan Kara <jack@suse.cz>, Nathan Scott <nathans@sgi.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        linux-kernel@vger.kernel.org
Subject: Re: Quota patches
In-Reply-To: <E17BHEJ-0006ed-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Alan Cox napisa?:
>>If we can do it for quota - we could possible remove the
>>IPC_OLD variant away as well. It's looong overdue by now,
>>becouse the IPC_OLD was not standard conformant anyway.
>>
>>I would be really really glad to do it iff ACK-ed.
> 
> 
> More code that takes almost no space, ensures old systems still work and 
> old XFree86 still runs on new kernels. Why remove it ?

It is an illusion to think that you can actually run *that old*
a.out binaries on a modern kernel I think.

BTW. (almost no space) * (many times) == huge number.

> If you want to design a mathematically elegant and small ultra clean OS go
> do it. Linux however has to work in the real world not in the happy clueless
> world of pure mathematical elegance

