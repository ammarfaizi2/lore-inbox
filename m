Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290596AbSBFPHt>; Wed, 6 Feb 2002 10:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290597AbSBFPHh>; Wed, 6 Feb 2002 10:07:37 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:59912 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290596AbSBFPH1>; Wed, 6 Feb 2002 10:07:27 -0500
Subject: Re: Cyrix CX5530 audio support?
To: thibaut@celestix.com (Thibaut Laurent)
Date: Wed, 6 Feb 2002 15:20:36 +0000 (GMT)
Cc: roy@karlsbakk.net (Roy Sigurd Karlsbakk), linux-kernel@vger.kernel.org
In-Reply-To: <20020206222540.59011685.thibaut@celestix.com> from "Thibaut Laurent" at Feb 06, 2002 10:25:40 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16YTsC-0005R1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The sb module from the kernel works.
> IIRC, sb16 had a hard time detecting the chip (though I haven't tested it again recently), but ALSA snd-card-sb16 is all right so you'll probably want to use the later.

Its been fine on my CS5530 since 2.2. We have the DMA emulation bug and the
disable_dma emulation bug fixed up nowdays

Alan
