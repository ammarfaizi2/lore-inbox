Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268325AbUIWITm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268325AbUIWITm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 04:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268326AbUIWITm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 04:19:42 -0400
Received: from mproxy.gmail.com ([216.239.56.248]:26685 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268325AbUIWITj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 04:19:39 -0400
Message-ID: <21d7e997040923011927860bb2@mail.gmail.com>
Date: Thu, 23 Sep 2004 18:19:36 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: gene.heskett@verizon.net
Subject: Re: 2.6.9-rc2-mm2 vs glxgears
Cc: linux-kernel@vger.kernel.org, Frank Phillips <fphillips@linuxmail.org>
In-Reply-To: <200409230327.11531.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040923052338.C1D0C21B32F@ws5-6.us4.outblaze.com>
	 <200409230327.11531.gene.heskett@verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Which even I have to agree is pretty pathetic.

What do you get on a Linus kernel, I'm not tracking -mm as much as I
should, the missing pci_enable_device might have caused some issues...

On my 2.6.8.1 at the moment glxgears stays constant enough, I'll boot
into a 2.6.9 later on and check it out...

What graphics card you have? 
Dave.

> 
> >courtesy Jon Smirl. See this thread:
> > http://marc.theaimsgroup.com/?t=109530394200002&r=1&w=2
> >
> >With this I get consistent 350s on 2.6.9-rc2-mm1-VP-S1.
> >
> >Frank
> 
> Other than the glxgears being slow, it seems to be working, so I'm
> gonna go sleep in it.
> 
> 
> 
> --
> Cheers, Gene
> "There are four boxes to be used in defense of liberty:
>  soap, ballot, jury, and ammo. Please use in that order."
> -Ed Howdershelt (Author)
> 99.26% setiathome rank, not too shabby for a WV hillbilly
> Yahoo.com attorneys please note, additions to this message
> by Gene Heskett are:
> Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
