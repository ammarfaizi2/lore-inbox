Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264610AbRFTURT>; Wed, 20 Jun 2001 16:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264613AbRFTURJ>; Wed, 20 Jun 2001 16:17:09 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:53511 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S264610AbRFTUQ4>; Wed, 20 Jun 2001 16:16:56 -0400
Date: Wed, 20 Jun 2001 16:16:55 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200106202016.f5KKGtU17599@devserv.devel.redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [OT] Threads, inelegance, and Java
In-Reply-To: <mailman.993067219.29993.linux-kernel2news@redhat.com>
In-Reply-To: <200106201927.PAA01484@mah21awu.cas.org> <mailman.993067219.29993.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This [code morphing and binary tranlation]
>  was set off to provide compensation for the biggest hurdle
> of VLIW design - insane code size and partially huge memmory
> bus bandwidth designs due to this. (Why do you think the itanim
> sucks on integer performance?)

First, Merced does not suck on integer performance.
It does about 300 SPEC CPU2000 at 733MHz, give or take,
subject to compiler improvements.
That blows all RISCs out of the water (except Alpha, yet.
The best result they submitted is 511 base 533 peak
at 833MHz).

> [...] Well but in relity underclocked modern
> design optimized for power consumtions beat the transmeta
> chip easly: Geode, and the recently announced VIA chip to name a few.

Man, where do you get this falsehood. TM-5400 is way, way
faster than Geode (several times for any benchmark).
This is exactly the reason why Transmetians love to
showcase DVD playing and other performance related
stuff - it is where they beat Geode. Geode's performance
is quite adequate for kiosk/POS app and it's a formiddable
competitor for anything that needs no performance.

> In comparision to chip design esp. targetted at low power consumtion
> the transmeta chip is laughable: this ARM please! My psion
> beats *ANY* chip from them by huge magnitude.

"Beats" by what metric? Sucks harder?

-- Pete
