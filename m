Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132366AbRAJAdQ>; Tue, 9 Jan 2001 19:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132630AbRAJAdG>; Tue, 9 Jan 2001 19:33:06 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:42198 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S132366AbRAJAcx>;
	Tue, 9 Jan 2001 19:32:53 -0500
Date: Wed, 10 Jan 2001 01:32:50 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200101100032.BAA04589@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org, taner@taner.net
Subject: Re: 2.2.18 and EMU10K1 problems...
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2001, Taner Halicioglu wrote:

>I probably missed a message or note or something about this, but when I went
>from 2.2.17 to 2.2.18, my sound card (SB Live!) stopped working.  It seems
>that in 2.2.18, it gets detected TWICE:
>
>--------------------------------
>kernel: Linux version 2.2.18
>[...]
>kernel: Creative EMU10K1 PCI Audio Driver, version 0.7, 20:05:23 Jan  7 2001 
>kernel: emu10k1: EMU10K1 rev 5 model 0x21 found, IO at 0xb400-0xb41f, IRQ 10 
>[... IDE, floppy, SCSI, eth0, partition check ...]
>kernel: Creative EMU10K1 PCI Audio Driver, version 0.7, 20:05:23 Jan  7 2001 
>--------------------------------

Known problem. Fixed in 2.2.19pre3.

/Mikael
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
