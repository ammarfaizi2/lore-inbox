Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290620AbSBFPm5>; Wed, 6 Feb 2002 10:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290629AbSBFPmh>; Wed, 6 Feb 2002 10:42:37 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:41481 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290620AbSBFPme>; Wed, 6 Feb 2002 10:42:34 -0500
Subject: Re: Cyrix CX5530 audio support?
To: roy@karlsbakk.net (Roy Sigurd Karlsbakk)
Date: Wed, 6 Feb 2002 15:55:48 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        thibaut@celestix.com (Thibaut Laurent), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0202061634160.6946-100000@mustard.heime.net> from "Roy Sigurd Karlsbakk" at Feb 06, 2002 04:34:30 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16YUQH-0005ZH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > This is with the sb16 driver?
> > SB16 driver and standard natsemi VSA1 firmware
> natsemi VSA1 firmware?

In the BIOS. There is 64K or so of deep magic SMM emulation firmware in the
Geode system. Much of the PC compatible I/O is not in fact real but smoke and
mirrors games played in the processor behind Linux back. This includes the
SB16 interface.

Alan
