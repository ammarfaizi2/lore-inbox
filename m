Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317187AbSFBOZq>; Sun, 2 Jun 2002 10:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317188AbSFBOZp>; Sun, 2 Jun 2002 10:25:45 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:16058 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S317187AbSFBOZp>; Sun, 2 Jun 2002 10:25:45 -0400
Date: Sun, 2 Jun 2002 16:25:20 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andre Hedrick <andre@linux-ide.org>, <linux-kernel@vger.kernel.org>
Subject: Re: FUD or FACTS ?? but a new FLAME!
In-Reply-To: <1023028184.23878.12.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.SOL.4.30.0206021621050.7413-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 2 Jun 2002, Alan Cox wrote:

> On Sun, 2002-06-02 at 13:11, Bartlomiej Zolnierkiewicz wrote:
> > So what should we do in case of overclocked PCI bus?
> > Get overclocked ATA or try to mess with timings?
>
> You cannot overclock the AMD on chipset IDE or the intel on chipset IDE.
> It doesn't actually matter what you do the system is going to be way out
> of wack. These are chipset bridges rather than card people ram into
> weird bits of hardware.

Please explain further, so in general AMD, Intel must not be overclocked?
Beacause if they are they are screwed (not only IDE)...?

> The VIA stuff and the Promise it makes some sense to try because they
> may be shoved in boxes with a 25MHz PCI clock, or in a few cases a
> horribly broke 37.5/41Mhz bus from the early chipsets that had 'idiot
> only' 75/83Mhz FSB options

--
Bartlomiej

