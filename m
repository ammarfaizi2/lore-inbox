Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129091AbQKYCG2>; Fri, 24 Nov 2000 21:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129153AbQKYCGR>; Fri, 24 Nov 2000 21:06:17 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:50191
        "EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
        id <S129091AbQKYCGC>; Fri, 24 Nov 2000 21:06:02 -0500
Date: Fri, 24 Nov 2000 17:35:41 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: James Lamanna <jlamanna@its.caltech.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Fasttrak100 questions...
In-Reply-To: <3A1EEFC8.16A48C24@its.caltech.edu>
Message-ID: <Pine.LNX.4.10.10011241734310.4479-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


NO!

Doing so VIOLATES the terms and agreement that you obtained the BINARY
Soft-Raid Engine and the GPL terms of the kernel.

On Fri, 24 Nov 2000, James Lamanna wrote:

> So, I have a system that has 2 45GB IDE drives connected
> up to a Promise Technologies Fasttrack 100.
> Promise Techonologies currently has a driver that you can compile
> against a 2.2 kernel into a module, but it also includes one
> proprietary object file.
> During my linux installation I was able to preload the module and
> have it detect the drives fine as a scsi device, so I was able to
> install the base system onto them.
>  
> The question is, is there a way to compile this module into the kernel
> so that it will automatically detect the card? A simple linking of the
> module into the scsi library by editing the Makefile doesn't seem to do
> it. It doesn't detect the drives if I boot off of a floppy with this
> kernel on it.
> 
> Also, is it possible for Lilo to even boot this without a RAM disk
> somewhere? I guess Lilo has to know about the drive, but it can't know
> without the module...so am I screwed into using floppies with a
> RAM disk image anyways?
> 
> Thanks,
> --James Lamanna
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
