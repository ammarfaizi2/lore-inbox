Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129683AbRBAGl2>; Thu, 1 Feb 2001 01:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129495AbRBAGlS>; Thu, 1 Feb 2001 01:41:18 -0500
Received: from [212.26.212.247] ([212.26.212.247]:40464 "EHLO zweden.rul.nl")
	by vger.kernel.org with ESMTP id <S129794AbRBAGlB>;
	Thu, 1 Feb 2001 01:41:01 -0500
Date: Thu, 1 Feb 2001 07:40:50 +0100 (MET)
From: Robert-Jan Oosterloo <oosterlo@worldonline.nl>
Reply-To: Robert-Jan Oosterloo <oosterlo@worldonline.nl>
To: Rainer Wiener <rainer@konqui.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: seti@home and es1371
In-Reply-To: <20010131171130.A1664@mulder.konqui.de>
Message-ID: <Pine.LNX.3.96.1010131203846.5978E-100000@zweden.rul.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2001, Rainer Wiener wrote:

> I hope you can help me. I have a problem with my on board soundcard and
> seti. I have a Gigabyte GA-7ZX Creative 5880 sound chip. I use the kernel
> driver es1371 and it works goot. But when I run seti@home I got some noise
> in my sound when I play mp3 and other sound. But it is not every time 10s
> play good than for 2 s bad and than 10s good 2s bad and so on. When I kill
> seti@home every thing is ok. So what can I do?
> 

I had the same problem. I have an Athlon 1000 Mhz on an Asus A7V board
with a Soundblaster 128 PCI which also uses the es1371 driver.
Yesterday I upgraded to kernel 2.4.1 and now my sound is okay.

> I have a Athlon 800 Mhz and 128 MB RAM

Regards

Robert-Jan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
