Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265399AbRF0Uxk>; Wed, 27 Jun 2001 16:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265398AbRF0Uxb>; Wed, 27 Jun 2001 16:53:31 -0400
Received: from Expansa.sns.it ([192.167.206.189]:61703 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S265300AbRF0UxQ>;
	Wed, 27 Jun 2001 16:53:16 -0400
Date: Wed, 27 Jun 2001 22:53:01 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: <joeja@mindspring.com>
cc: Dave Jones <davej@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alex Deucher <adeucher@UU.NET>, <linux-kernel@vger.kernel.org>
Subject: Re: Re: AMD thunderbird oops
In-Reply-To: <Springmail.105.993672371.0.48374000@www.springmail.com>
Message-ID: <Pine.LNX.4.33.0106272246540.21038-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 27 Jun 2001 joeja@mindspring.com wrote:

> Well considering the other night the power supply went dead, I think that is part of the problem.  It is brand new, and I am being sent another one (free of course).
I would have bet that power supply was erogating elettricity with a
discontinous intensity.
I saw that RAM stability is the first think to be affected (together
with L2 cache stability) in those cases.
>
> I also had my mb loaded at the time (scsi cd-rw, cdrom, internal zip, floppy, 1 hd, Sound card, video, modem, NIC, scsi card) but my last tyan was fine with that load it may be a kt7a thing.
>
> Several people said that random (keyword here) oopses are more often a hardware thing.  I wonder if the kt7a is going to be able to perform  fully loaded..
>
> is anyone running one fully loaded? 4 ide drives, 2 floppy, (5 pci and 1 isa) or 6pci, agp, 512MEG+ RAM?

yes,

1.300 Mhz

1 agp
4 pci
1 isa (I love my sound blaster 16 on ISA, could not live without)
3 disks
1 floppy
1 zip
1 dvd
5 fans

350 watt power supply.


Luigi

> Joe
>
> Dave Jones <davej@suse.de> wrote:
> > On Tue, 26 Jun 2001, Alan Cox wrote:
> > My current speculation is that the sdram setup on some of these boards can't
> > actually take the full CPU spec caused by these hand tuned routines. There is
> > some evidence to support that as several other boards only work with Athlon
> > optimisation if you set the BIOS options to 'conservative' not 'optimised'
>
> Interesting, and plausable theory. It would be more interesting to see
> register dumps of the memory timing registers on both good and bad
> systems, to see if this is the case.
>
> Unfortunatly afair the register level specs of all the affected chipsets
> are not available.
>
> regards,
>
> Dave.
>
> --
> | Dave Jones.        http://www.suse.de/~davej
> | SuSE Labs
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

