Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280667AbRKNPdV>; Wed, 14 Nov 2001 10:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280671AbRKNPdE>; Wed, 14 Nov 2001 10:33:04 -0500
Received: from sdsl-64-32-181-131.dsl.lax.megapath.net ([64.32.181.131]:10457
	"EHLO brigadier.ontimesupport.com") by vger.kernel.org with ESMTP
	id <S280667AbRKNPcw>; Wed, 14 Nov 2001 10:32:52 -0500
Message-Id: <5.1.0.14.0.20011114092215.00a89008@127.0.0.1>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 14 Nov 2001 09:31:29 -0600
To: Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>
From: Matthew Sell <msell@ontimesupport.com>
Subject: Re: Athlon SMP blues - kernels 2.4.[9 13 15-pre4]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.33.0111141500350.14971-100000@gurney>
In-Reply-To: <3BF285D7.8F5AAB6E@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We're using the 1.4 GHz Athlons (non-MP) in a Tyan S2460 with no problems.

Check some reviews, such as from Tom's Hardware or AnandTech to see some 
specifics regarding the use of non-MP processors in SMP mode. It definitely 
is possible and it works fine, but check those websites for details from 
someone who knows a heck of a lot more about SMP than I do.....     : )


         - Matt



At 03:04 PM 11/14/2001 +0000, you wrote:
> > > Hi folks - I'm having real problems getting our new dual CPU server
> > > going. It's a 2x Athlon XP 1800+ on a Tyan mobo, AMD 760MP chipset, with
> >
> > Ehm you know that XP cpu's don't support SMP configuration ?
>
>Erm, no....
>
>If this really is the case, then obviously my supplier doesn't know
>either, as he's quite definitively stuck two of them on my mobo!
>Linux happily detects two XP 1800+ CPUs on boot, but then both SMP
>and UP kernels fail in this strange way. If they didn't boot at all, it
>would almost be more helpful ;-)
>
>Cheers
>Alastair
>
>_____________________________________________
>Alastair Stevens
>MRC Biostatistics Unit
>Cambridge UK
>---------------------------------------------
>phone - 01223 330383
>email - alastair.stevens@mrc-bsu.cam.ac.uk
>web - www.mrc-bsu.cam.ac.uk
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/



Matthew Sell
Programmer
On Time Support, Inc.
www.ontimesupport.com
(281) 296-6066

Join the Metrology Software discussion group METLIST!
http://www.ontimesupport.com/cgi-bin/mojo/mojo.cgi


"One World, One Web, One Program" - Microsoft Promotional Ad
"Ein Volk, Ein Reich, Ein Fuhrer" - Adolf Hitler

Many thanks for this tagline to a fellow RGVAC'er...

