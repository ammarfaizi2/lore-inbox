Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129712AbRCCTpK>; Sat, 3 Mar 2001 14:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129727AbRCCTov>; Sat, 3 Mar 2001 14:44:51 -0500
Received: from cr626425-a.bloor1.on.wave.home.com ([24.156.35.8]:19215 "EHLO
	spqr.damncats.org") by vger.kernel.org with ESMTP
	id <S129725AbRCCTok>; Sat, 3 Mar 2001 14:44:40 -0500
Message-ID: <3AA14870.E4439DF4@damncats.org>
Date: Sat, 03 Mar 2001 14:39:28 -0500
From: John Cavan <johnc@damncats.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.2-ac10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2ac11
In-Reply-To: <E14ZHlI-0003zZ-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
>         ftp://ftp.kernel.org/pub/linux/kernel/people/alan/2.4/
> 
> 2.4.2-ac11

Doesn't apply cleanly against a 2.4.2 tree...

./mm/slab.c.rej
./net/irda/irnet/irnet.h.rej
./arch/i386/kernel/traps.c.rej
./drivers/net/tulip/tulip.h.rej
./drivers/net/tulip/tulip_core.c.rej
./drivers/net/tulip/pnic.c.rej
./drivers/net/pcmcia/wavelan_cs.c.rej
./drivers/pci/pci.c.rej
./drivers/char/i810_rng.c.rej
./Makefile.rej

Also, a lot of them suceeded, but with offsets.

John
