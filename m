Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261721AbSKHJeJ>; Fri, 8 Nov 2002 04:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261723AbSKHJeJ>; Fri, 8 Nov 2002 04:34:09 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:7817 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S261721AbSKHJeI>;
	Fri, 8 Nov 2002 04:34:08 -0500
Date: Fri, 8 Nov 2002 10:40:28 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Steven Newbury <lkml@ntlworld.com>
cc: Nico Schottelius <schottelius@wdt.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       PCMCIA <dhinds@zen.stanford.edu>
Subject: Re: [BUGS 2.5.45]
In-Reply-To: <3DCADCD1.8010406@ntlworld.com>
Message-ID: <Pine.GSO.4.21.0211081039450.23267-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Nov 2002, Steven Newbury wrote:
> I was also surprised to notice that there is no support in X for FBDev 
> with mach64 cards.  I was under the impression that they used to be 
> common on older powermacs where the fbdev was essential.

The XFree86 Mach64 maintainer doesn't like fbdev.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

