Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267327AbUITU1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267327AbUITU1g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 16:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267314AbUITU1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 16:27:36 -0400
Received: from main.gmane.org ([80.91.229.2]:26757 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S267330AbUITUXm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 16:23:42 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: GPL source code for Smart USB 56 modem (includes ALSA AC97           patch)
Date: Mon, 20 Sep 2004 22:23:11 +0200
Message-ID: <MPG.1bb958d35c42f5899896f2@news.gmane.org>
References: <200409111850.i8BIowaq013662@harpo.it.uu.se> <20040912011128.031f804a@localhost> <Pine.LNX.4.60.0409131526050.29875@tomservo.workpc.tds.net> <20040914175949.6b59a032@sashak.lan> <MPG.1bb164a85e6c9d459896e9@news.gmane.org> <20040915035820.1cdccaa5@localhost> <MPG.1bb4d933f584efee9896f0@news.gmane.org> <20040918142900.06a9ff96@localhost> <MPG.1bb665cd5b40a4ed9896f1@news.gmane.org> <20040918232055.00cb25b0@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ppp-194-140.29-151.libero.it
User-Agent: MicroPlanet-Gravity/2.70.2067
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sasha Khapyorsky wrote:
> On Sat, 18 Sep 2004 16:35:32 +0200
> Giuseppe Bilotta <bilotta78@hotpop.com> wrote:
> > > parport: PnPBIOS parport detected.
> > > parport0: PC-style at 0x378 (0x778), irq 7, dma 1 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
> > > parport0: irq 7 in use, resorting to polled operation
> 
> I don't know really, but suppose that parport does not accept irq sharing.

Ok, I'll inquire with the parport people.

> > I will. Do you have any idea on the "not ready" issue?
> 
> This one is more interesting, probably special patch is necessary for conexant codec, let's see.
> 
> Please report bug to alsa and attach there output of 'lspci -vv' and tar of '/proc/asound' directory (or send to me).

Done. (Has been automatically assigned to you, it seems.)

-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)

