Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272897AbRISTsP>; Wed, 19 Sep 2001 15:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274149AbRISTsF>; Wed, 19 Sep 2001 15:48:05 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:6404 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272897AbRISTr6>; Wed, 19 Sep 2001 15:47:58 -0400
Subject: Re: [PATCH] fbdev config fixes (ac edition)
To: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 19 Sep 2001 20:52:49 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-fbdev-devel@lists.sourceforge.net (Linux Frame Buffer Device
	Development),
        linux-kernel@vger.kernel.org (Linux Kernel Development)
In-Reply-To: <Pine.GSO.4.21.0109190816360.14079-100000@mullein.sonytel.be> from "Geert Uytterhoeven" at Sep 19, 2001 08:19:40 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15jnOr-0003iD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Fix fbdev config glitches that were introduced recently:
>   - Remove duplicate CONFIG_* section for DECstation
>   - Remove duplicate initialization code for pmagbafb, pmagbbfb, and maxinefb

Please send those to Ralf@gnu.org not me

>   - Sstfb doesn't use resource management, so move its initialization to the
>     correct section (why do people never read comments in source code?)

Grin - it will be doing that soon
