Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131232AbRBPUuL>; Fri, 16 Feb 2001 15:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131239AbRBPUuC>; Fri, 16 Feb 2001 15:50:02 -0500
Received: from jkd.penguinfarm.com ([12.32.79.69]:5248 "HELO
	jkd.penguinfarm.com") by vger.kernel.org with SMTP
	id <S131232AbRBPUts>; Fri, 16 Feb 2001 15:49:48 -0500
Message-ID: <3A8D922A.9060102@penguinfarm.com>
Date: Fri, 16 Feb 2001 15:48:42 -0500
From: Jason Straight <junfan@penguinfarm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.1-ac15 i686; en-US; 0.8) Gecko/20010216
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: (2.4.1-ac15) Wont set using_dma = 1 with hdparm
In-Reply-To: <Pine.LNX.4.10.10102161508300.25507-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doh, I forgot to turn on the DMA options in the kernel.
Thanks.


Mark Hahn wrote:

> you didn't mention what ide controller you're using,
> which sort of makes a big difference.  with modern kernels,
> it shouldn't be necessary to hdparm at all, since you 
> can select such config at compile time.
> 
>> 
> 
> which is normal when you haven't configured the chipset-specific
> ide code, and are using generic ide stuff.
> 
> 
> 

-- 
Jason Straight

