Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269183AbUJWFFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269183AbUJWFFW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 01:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269328AbUJWFEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 01:04:21 -0400
Received: from out005pub.verizon.net ([206.46.170.143]:31916 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP id S269321AbUJWEpx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 00:45:53 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
Date: Sat, 23 Oct 2004 00:45:49 -0400
User-Agent: KMail/1.7
Cc: Stephen Lewis <lewis@napanet.net>
References: <20041022101529.732254eb.lewis@napanet.net>
In-Reply-To: <20041022101529.732254eb.lewis@napanet.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410230045.49517.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [151.205.58.180] at Fri, 22 Oct 2004 23:45:50 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 22 October 2004 13:15, Stephen Lewis wrote:
>Timothy Miller wrote:
>> The reason this idea came up is because I, as a user of Linux, am
>> often frustrated by the lack of open-source support for graphics
>> cards which are not "pre-owned".  Sure, SOME companies release
>> specs so that we can develop open source drivers, but those cards
>> tend to be prohibitively expensive, slower than their cheaper
>> counterparts from ATI or nVidia, and they STILL don't document the
>> internals of the BIOS so that the card can be ported to a non-x86
>> system.
>
>What has this to do with the kernel? More relevant on X server,
> OpenGL or GPGPU lists?
>
>Baseline - I can get accelerated 3D graphics and video overlay
>and YV12 and VGA registers with open source driver that compiles
>for PowerPC and DEC Alpha today for $85 - Radeon 7500 PCI.

'scuse me, but have you tried to buy one of those locally?  The 
unwashed masses of us are stuck with whatever we can buy at Circuit 
City et all, and the cheapest thing today for an AGP slot is the 
house brands of the 9200 SE w/128 megs of ddr ram.

>X.org 'ati' driver at http://x.org
>http://freedesktop.org/cgi-bin/viewcvs.cgi/xc/programs/Xserver/hw/xf
>ree86/drivers/ati/?root=xorg If you can improve on that then I will
> buy one for each of my Alpha and PowerPC systems.

Has this links code been substantially updated since the 6.8.1 release 
as built on an x86 system?  If not, then this common readily 
available card is still not supported all that well, my lspci outputs 
say the vendor codes are unknown.  And my glxgears is 198 fps.

>
>http://www.gpgpu.org/ are programming multivendor graphics cards for
>general purpose computing BUT the toolchain involves a proprietary
>compiler which is single platform.
>What good is a card with open source hardware and open source
>driver that is programmable BUT the toolchain is proprietary?
>
>Stephen Lewis
>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.28% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
