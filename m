Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316234AbSEVQJ2>; Wed, 22 May 2002 12:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316227AbSEVQJY>; Wed, 22 May 2002 12:09:24 -0400
Received: from [195.63.194.11] ([195.63.194.11]:49681 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316235AbSEVQH7>; Wed, 22 May 2002 12:07:59 -0400
Message-ID: <3CEBB385.5040904@evision-ventures.com>
Date: Wed, 22 May 2002 17:04:37 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Russell King <rmk@arm.linux.org.uk>, jack@suse.cz,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.17
In-Reply-To: <Pine.LNX.4.44.0205220901430.7580-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Linus Torvalds napisa?:
> 
> On Wed, 22 May 2002, Russell King wrote:
> 
>>/proc/sys has a clean and clear purpose.
> 
> 
> Yes, but it _:would_ be good to make the quota stuff use the existign
> helper functions to make it much cleaner.
> 
> And some of those helper functions are definitely from sysctl's: splitting
> up the quota file into multiple sysctls (_and_ moving it to /proc/sys/fs)
> sounds like a good idea to me.

Well I'm actually coding this right now :-).

