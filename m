Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273361AbRIWKGa>; Sun, 23 Sep 2001 06:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273366AbRIWKGU>; Sun, 23 Sep 2001 06:06:20 -0400
Received: from ns1.yifansoft.com ([64.61.26.50]:26462 "HELO mail.yifansoft.com")
	by vger.kernel.org with SMTP id <S273361AbRIWKGI>;
	Sun, 23 Sep 2001 06:06:08 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jim Blomo <Blackfoot@yifan.net>
Reply-To: Blackfoot@yifan.net
To: linux-kernel@vger.kernel.org
Subject: Re: Athlon doesn't like Athlon optimisation?
Date: Sun, 23 Sep 2001 03:04:22 -0700
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010923100613Z273361-760+15773@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Sep 2001, Jim Blomo wrote: 
> Hi, I am having a similar problem with my new board/chip...
> Motherboard + chipset: 
>  ECS K7AMA + Ali Magic 1645 & Magic 1535D 
> CPU + multiplier: 
>  Athlon Thunderbird 1.33Ghz not overclocked 

Since a probable cause was found for the VIA chipset, is there any way for me 
to check if my board is having a similar problem?  I have tried using an 
older BIOS version, upgrading to 2.4.10-pre14, and even applying the VIA 
patch, with no effect on my problem.  When the kernel is compiled with the 
Athlon settings, absolutely nothing happens after LILO uncompresses the 
image. The keyboard and powerswitch also stop responding and I am forced to 
do a hard reboot.  k6, ppro, and i386 settings let Linux run without errors 
for days.  Thanks for CCing me the info as I am not subscribed to this list,

Jim
