Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130614AbQKRTGn>; Sat, 18 Nov 2000 14:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130751AbQKRTGd>; Sat, 18 Nov 2000 14:06:33 -0500
Received: from getafix.lostland.net ([216.29.29.27]:28580 "EHLO
	getafix.lostland.net") by vger.kernel.org with ESMTP
	id <S130614AbQKRTGW>; Sat, 18 Nov 2000 14:06:22 -0500
Date: Sat, 18 Nov 2000 13:34:49 -0500 (EST)
From: adrian <jimbud@lostland.net>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Freeze on FPU exception with Athlon
In-Reply-To: <Pine.LNX.4.10.10011181002190.1655-100000@cesium.transmeta.com>
Message-ID: <Pine.BSO.4.30.0011181332030.1052-100000@getafix.lostland.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 18 Nov 2000, Linus Torvalds wrote:

> There's almost certainly more than that. I'd love to have a report on my
> asm-only version, but even so I suspect it also requires the 3dnow stuff,

I tried all three versions, and no freezes.  I forgot to mention the tests
were run on a model 2 Athlon (original slot K7, .18 micron).  The kernel
is compiled with 3dnow support.

Regards,
Adrian




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
