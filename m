Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290598AbSBFPNR>; Wed, 6 Feb 2002 10:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290605AbSBFPNH>; Wed, 6 Feb 2002 10:13:07 -0500
Received: from [194.234.65.222] ([194.234.65.222]:65412 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S290598AbSBFPNA>; Wed, 6 Feb 2002 10:13:00 -0500
Date: Wed, 6 Feb 2002 16:12:40 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Thibaut Laurent <thibaut@celestix.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Cyrix CX5530 audio support?
In-Reply-To: <E16YTsC-0005R1-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0202061612210.6844-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The sb module from the kernel works.
> > IIRC, sb16 had a hard time detecting the chip (though I haven't tested it again recently), but ALSA snd-card-sb16 is all right so you'll probably want to use the later.
>
> Its been fine on my CS5530 since 2.2. We have the DMA emulation bug and the
> disable_dma emulation bug fixed up nowdays

This is with the sb16 driver?

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

