Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279984AbRKIQ5b>; Fri, 9 Nov 2001 11:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279987AbRKIQ5V>; Fri, 9 Nov 2001 11:57:21 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:385 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S279984AbRKIQ5O>; Fri, 9 Nov 2001 11:57:14 -0500
Date: Fri, 9 Nov 2001 09:56:54 -0700
Message-Id: <200111091656.fA9GusD06947@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andre Hedrick <andre@linux-ide.org>
Subject: Re: Lockup in IDE code
In-Reply-To: <1005299137.13841.27.camel@nomade>
In-Reply-To: <200111090217.fA92HYh00521@vindaloo.ras.ucalgary.ca>
	<1005299137.13841.27.camel@nomade>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

GXavier Bestel writes:
> le ven 09-11-2001 à 03:17, Richard Gooch a écrit :
> >   Hi, all. I tried to use my IDE CD-ROM today, the first time in a
> > long while. When attempting to mount it, the machine locked up,
> > hard. Even SysReq didn't work.
> 
> Do you have a read error on your CD ?

No. I did mention that when I turned off DMA, it worked fine.

BTW: I've gotten a few "helpful" responses saying "try using hdparm to
turn off DMA". Well, those people obviously hadn't bothered reading
all my message, because I stated that when I disabled DMA with hdparm,
it worked fine.
</grumble>

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
