Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265377AbRGOAwF>; Sat, 14 Jul 2001 20:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265385AbRGOAvp>; Sat, 14 Jul 2001 20:51:45 -0400
Received: from Expansa.sns.it ([192.167.206.189]:32787 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S265377AbRGOAvl>;
	Sat, 14 Jul 2001 20:51:41 -0400
Date: Sun, 15 Jul 2001 02:51:27 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Gabriel Friedmann <gfriedmann@mediaone.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Again: Linux 2.4.x and AMD Athlon
In-Reply-To: <200107141954.f6EJsUS09999@demai05.mw.mediaone.net>
Message-ID: <Pine.LNX.4.33.0107150243430.16333-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 14 Jul 2001, Gabriel Friedmann wrote:

>
> This bums me out.  AS i am using ABIT kt7a-raid with the kt133a chipset, and
> 3dnow kernel optimizations and i oops right as i boot (sometimes before i
> complete any init-scripts).
>
> Anyways...  I am confirming a problem with my via chipset and 3dnow
> optimizations.  VIA82CXXX in kernel support not affecting outcome.
>
mmm, i have also one Athlon (my workstation) with the same MB and
everything works with AThlon optimizzations and 3dnow enabled...

When i got an oops it was because i configured the bios to erogate just
1.7 volt to the processor instead of default 1.75 volts (too hot here,
with 31 degrees it is difficoult to keep cold a processor like this).

I think that FSB speed is the key, at less for some of the VIA chipset. I
have there an Athlon 1300
Mhz with 13x100 setting and FSB of 200 Mhz.

Are you using a processor with 266 Mhz FSB?

(All 266 Mhz FSB Athlon I administer are running on AMD chipset).

bests
Luigi Genoni


