Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290614AbSBFP25>; Wed, 6 Feb 2002 10:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290627AbSBFP2r>; Wed, 6 Feb 2002 10:28:47 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:25353 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290619AbSBFP2c>; Wed, 6 Feb 2002 10:28:32 -0500
Subject: Re: Cyrix CX5530 audio support?
To: roy@karlsbakk.net (Roy Sigurd Karlsbakk)
Date: Wed, 6 Feb 2002 15:41:48 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        thibaut@celestix.com (Thibaut Laurent), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0202061612210.6844-100000@mustard.heime.net> from "Roy Sigurd Karlsbakk" at Feb 06, 2002 04:12:40 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16YUCi-0005Vu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Its been fine on my CS5530 since 2.2. We have the DMA emulation bug and the
> > disable_dma emulation bug fixed up nowdays
> 
> This is with the sb16 driver?

SB16 driver and standard natsemi VSA1 firmware

