Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317263AbSFGRox>; Fri, 7 Jun 2002 13:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317310AbSFGRow>; Fri, 7 Jun 2002 13:44:52 -0400
Received: from horus.webmotion.com ([209.87.243.246]:49898 "EHLO
	horus.webmotion.ca") by vger.kernel.org with ESMTP
	id <S317263AbSFGRov>; Fri, 7 Jun 2002 13:44:51 -0400
Message-ID: <3D00F107.8070402@bonin.ca>
Date: Fri, 07 Jun 2002 13:44:39 -0400
From: Andre Bonin <kernel@bonin.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020516
X-Accept-Language: en-us, fr-ca
MIME-Version: 1.0
To: Chris Fuller <cfuller@broadjump.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Tyan S2464 (K7 SMP) + EMU10K1 hardlocks
In-Reply-To: <97B71B827DFB2B448A73EC00E5DA0EE605E04A@logos.inhouse.broadjump.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Fuller wrote:
> I've established by now that the problem is definitely not with the
> Linux kernel, but there was a discussion here about this very issue last
> August, and I haven't found a reference to it anywhere else, so please
> help if you can. :)
> 
> I'm seeing hardlocks in various 2.4 kernels (10, 18, 19-pre8, all SMP):
>   mobo=Tyan S2464 (K7 Thunderbird) SMP
>   NVidia GeForce4 AGP
>   SBLive! Platinum 5.1
>   Two 40G IDE hard drives

Creative Labs warns that it's sblive series of cards aren't compatible 
with SMP systems.  Though i've had the S2460 motherboard and the only 
trouble i have had was that EAX didn't work properly.  A friend of mine 
has an sblive with a dual celeron and he also has had this problem of 
deadlocks with the SBLive.  The audigy however is fully compatible.


Also, make sure you have an adequate power supply.

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 



