Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129561AbQLBNfo>; Sat, 2 Dec 2000 08:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129965AbQLBNfe>; Sat, 2 Dec 2000 08:35:34 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:21372 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129561AbQLBNfV>; Sat, 2 Dec 2000 08:35:21 -0500
Subject: Re: Transmeta and Linux-2.4.0-test12-pre3
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sat, 2 Dec 2000 13:04:34 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <90a065$5ai$1@penguin.transmeta.com> from "Linus Torvalds" at Dec 01, 2000 09:09:25 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E142CLF-0001WT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Anyway, I do have this machine working now, although not everything is
> to my liking.  Unlike older picture-books, for example, this one has a
> WinModem.  Ugh.  And the sound chip is supported, but only by the ALSA
> driver (the OSS version is too broken to be used). 

The OSS ymf_sb legacy driver doesn't work on the Vaio, it seems they didnt
wire it to do the sideband crap. The newer ymf driver (the experimental one)
Pete Zaitcev did should. I'll submit that from 2.2.18pre to 2.4 at some point

> But the camera is cool, and works beautifully (once you get XFree86
> happy) thanks to Andrew Tridgell.  (If I could just coax the X server
> into giving my a YUV overlay I could play DVD's with this thing). 

Start at http://www.core.binghamton.edu/~insomnia/gatos/

Enjoy 8)

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
