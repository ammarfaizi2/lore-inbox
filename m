Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313174AbSEHLyh>; Wed, 8 May 2002 07:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313187AbSEHLyg>; Wed, 8 May 2002 07:54:36 -0400
Received: from [195.63.194.11] ([195.63.194.11]:38664 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313174AbSEHLyf>; Wed, 8 May 2002 07:54:35 -0400
Message-ID: <3CD9033D.6050105@evision-ventures.com>
Date: Wed, 08 May 2002 12:51:41 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Guest section DW <dwguest@win.tue.nl>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
In-Reply-To: <E175QHU-0001Q6-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Alan Cox napisa?:
>>about it... and you know I'm evil... hmmm...
>>well why just don't let it be like that. It's functionally somehow the
>>responsibility of the /sbin/hotplug thing anyway...
> 
> 
> How do you intend to order a sequence of I/O operations precisely against a 
> partition table change driven from user space ? Thats one I can't see a nice 
> answer for, and having a raid controller that can do on the fly volume
> resizing/creation/deletion its not just a matter of curiosity


Nahh Alan we are just talking about the ide-cs stuff. I'm not that "evil".

