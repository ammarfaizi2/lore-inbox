Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315540AbSEMEGP>; Mon, 13 May 2002 00:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315541AbSEMEGO>; Mon, 13 May 2002 00:06:14 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:55314
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S315540AbSEMEGM>; Mon, 13 May 2002 00:06:12 -0400
Date: Sun, 12 May 2002 21:03:36 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Andre LeBlanc <ap.leblanc@shaw.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: More UDMA Troubles
In-Reply-To: <003f01c1fa36$0106ded0$2000a8c0@metalbox>
Message-ID: <Pine.LNX.4.10.10205122101560.3133-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andre <deja vu feeling>

Did this happen in 2.4?  If so please give me the exact kernel because
doing DMA on a PIO transaction is a driver bug!

On Sun, 12 May 2002, Andre LeBlanc wrote:

> Ok, I signed up to this list from work under the name aeleblanc, now i'm at
> home, so to see this history look at the other messages, anyway, i was
> having alot of troubles getting DMA Working on my system, its a duron 1GHz
> on an ECS Motherboard w/ an SiS Chipset. Actually, even with DMA Disabled i
> was getting Hard drive errors... anyway, I tried compiling 2.5.15 because i
> was told that 2.4.19-pre8 and up had better IDE Support, but during the boot
> process on the new Kernel I get the following messages
> 
> hda: dma_intr: error=0x84 {DriveStatusError BadCRC }
> hda: recalibrating!
> { dma_intr }
> hda: dma_intr: error=0x84 {DriveStatusError BadCRC }
> { dma_intr }
> hdb: DMA Disabled
> 
> then the system Locks solid.
> 
> can anyone help me with this, this is the third kernel I've tried and
> they've all had very serisous problems.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

