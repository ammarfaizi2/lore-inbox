Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129276AbRBYOHB>; Sun, 25 Feb 2001 09:07:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129257AbRBYOGv>; Sun, 25 Feb 2001 09:06:51 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:60934 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129253AbRBYOGg>; Sun, 25 Feb 2001 09:06:36 -0500
Subject: Re: ide / usb problem
To: 0@pervalidus.net (Frédéric L. W. Meunier)
Date: Sun, 25 Feb 2001 13:56:30 +0000 (GMT)
Cc: jdinardo@ix.netcom.com (jerry),
        linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <20010225060326.K127@pervalidus> from "Frédéric L. W. Meunier" at Feb 25, 2001 06:03:26 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14X1f7-00033Q-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> hda: dma_intr: status=3D0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=3D0x84 { DriveStatusError BadCRC }
> ide0: reset: success
> 
> Again, if it's really a cable problem, then ASUS is selling
> cables that don't work with UDMA66 (but they sell it as
> UDMA66).

To get ATA66 working well you need the right cables, you also need a machine
that is to spec on interference and the like. You cant just point at the cables
althoigh they are first guess.


