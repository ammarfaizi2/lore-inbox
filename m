Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266944AbTBQJbI>; Mon, 17 Feb 2003 04:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266948AbTBQJbI>; Mon, 17 Feb 2003 04:31:08 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:23190 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S266944AbTBQJbH>;
	Mon, 17 Feb 2003 04:31:07 -0500
Date: Mon, 17 Feb 2003 10:40:33 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Art Haas <ahaas@airmail.net>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux/m68k on Mac <linux-mac68k@mac.linux-m68k.org>,
       Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [PATCH] C99 initializers for drivers/macintosh/mac_hid.c
In-Reply-To: <20030215203928.GC20146@debian>
Message-ID: <Pine.GSO.4.21.0302171039350.16817-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Feb 2003, Art Haas wrote:
> This patch converts the file to use C99 initializers to improve
> readability and remove warnings if '-W' is used.
> 
> Art Haas
> 
> ===== drivers/macintosh/mac_hid.c 1.8 vs edited =====
> --- 1.8/drivers/macintosh/mac_hid.c	Tue Oct  8 05:51:31 2002
> +++ edited/drivers/macintosh/mac_hid.c	Sat Feb 15 13:19:37 2003

Apparently this file is no longer used? I couldn't find CONFIG_MAC_EMUMOUSEBTN
in any Kconfig, unless it's in the PPC tree only.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

