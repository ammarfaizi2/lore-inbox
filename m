Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268331AbRHBBLd>; Wed, 1 Aug 2001 21:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268358AbRHBBLX>; Wed, 1 Aug 2001 21:11:23 -0400
Received: from Expansa.sns.it ([192.167.206.189]:47879 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S268331AbRHBBLL>;
	Wed, 1 Aug 2001 21:11:11 -0400
Date: Thu, 2 Aug 2001 03:11:02 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: "Nadav Har'El" <nyh@math.technion.ac.il>
cc: <linux-kernel@vger.kernel.org>, <agmon@techunix.technion.ac.il>
Subject: Re: SMP possible with AMD CPUs?
In-Reply-To: <20010801230441.A19396@leeor.math.technion.ac.il>
Message-ID: <Pine.LNX.4.33.0108020309220.23376-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Runs stable and fast on a dual Athlon 1.2 Ghz, amd chipset.
tested with kernel 2.4.6 and 2.4.7

Luigi

On Wed, 1 Aug 2001, Nadav Har'El wrote:

> A Linux user in a local Linux club asked me whether Linux support SMP with
> AMD (rather than Intel Pentium) CPUs. She said that a year ago she was told
> Linux 2.2 couldn't, and that she was wondering whether the new Linux 2.4 can.
> I didn't know the answer, so I started digging.
>
> I tried looking with various search search engines, but found nothing about
> this subject. Looking through the source code, it appears that SMP with AMDs
> *might* be supported, but I couldn't find any comment confirming that. The
> relevant FAQs, READMEs, and so on that I found are all from the 2.2 kernel
> era.
>
> So, does Linux support SMP on AMD CPUs?
>
> By the way, here's a fragment from the outdated (1999) SMP-HOWTO at
> http://www.phy.duke.edu/brahma/smp-faq/smp-howto-3.html explaining why SMP
> wasn't possible in kernel 2.2 and contemporary AMD processors:
>
>      1.  Can I use my Cyrix/AMD/non-Intel CPU in SMP?
>
>          Short answer: no.
>
>          Long answer: Intel claims ownership to the APIC SMP scheme, and
>          unless a company licenses it from Intel they may not use it. There
>          are currently no companies that have done so. (This of course can
>          change in the future) FYI - Both Cyrix and AMD support the non-
>          proprietary OpenPIC SMP standard but currently there are no
>          motherboards that use it.
>
> Thanks.
>
> --
> Nadav Har'El                        |       Wednesday, Aug  1 2001, 13 Av 5761
> nyh@math.technion.ac.il             |-----------------------------------------
> Phone: +972-53-245868, ICQ 13349191 |The socks in my drawer are like
> http://nadav.harel.org.il           |snowflakes: No two are alike.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

