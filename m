Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264538AbUAASzZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 13:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264539AbUAASzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 13:55:24 -0500
Received: from witte.sonytel.be ([80.88.33.193]:1170 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S264538AbUAASzX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 13:55:23 -0500
Date: Thu, 1 Jan 2004 19:55:20 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: claas@rootdir.de, Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0: atyfb broken
In-Reply-To: <20031230212609.GA4267@rootdir.de>
Message-ID: <Pine.GSO.4.58.0401011951510.2916@waterleaf.sonytel.be>
References: <20031230212609.GA4267@rootdir.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Dec 2003, Claas Langbehn wrote:
> I have got an HP omnibook 4150B. When booting with atyfb,
> the kernel messages look great:
>
> atyfb: 3D RAGE Mobility (PCI) [0x4c4d rev 0x64] 8M SDRAM, 29.498928 MHz XTAL, 230 MHz PLL, 50 Mhz MCLK
> fb0: ATY Mach64 frame buffer device on PCI
>
> But either the screen is black and I see only the cursor and Background
> colors (CONFIG_FRAMEBUFFER_CONSOLE disabled), but X11 starts fine.

Does your notebook work with the atyfb in 2.4.23? With the one in 2.4.22 and
earlier?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
