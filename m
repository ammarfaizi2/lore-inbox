Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267244AbRGPIve>; Mon, 16 Jul 2001 04:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267255AbRGPIvY>; Mon, 16 Jul 2001 04:51:24 -0400
Received: from rcum.uni-mb.si ([164.8.2.10]:5892 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S267253AbRGPIvQ>;
	Mon, 16 Jul 2001 04:51:16 -0400
Date: Mon, 16 Jul 2001 10:50:28 +0200
From: David Balazic <david.balazic@uni-mb.si>
Subject: Re: Again: Linux 2.4.x and AMD Athlon
To: puckwork@madz.net
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-id: <3B52AAD4.C66CCF13@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Foerster (puckwork@madz.net) wrote :
> Hi, 
> 
> > Kenneth Vestergaard Schmidt wrote: 
> >> 
> >> Thomas Foerster wrote: 
> >> > Seems to be the problem with the AMD optimazion in the kernel. 
> >> 
> >> Funny, I have only had one minor problem with my setup. It's the same 
> >> processor, only with one 512 meg PC133 block, and the ASUS A7V133 
> >> motherboard (which is equipped with the same chipset). My videocard is also 
> >> the same (ASUS V-7700), but my PSU is only 300Mhz. 
> >> 
> 
> > I am wondering if you are using the NVidia binary driver for X. They 
> > seem to cause some "funny" things like SIGSEGVs and random hangs. Even 
> > without K7 optimizations. 
> 
> I do. I use the version coming with redhat 7.1 

Just to clarify : The nVidia drivers shipped with redhat 7.1 ( and any
other version ) are the free ones from xfree86.org and not the proprietary
ones from nVidia.

To avoid confusion maybe people should say 'proprietary' or 'closed source'
instead of 'binary' as free software is 'binary' too.

> Do they behave different when being non root? 
> 
> Thomas 

-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
