Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261768AbTDBUBa>; Wed, 2 Apr 2003 15:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261801AbTDBUB3>; Wed, 2 Apr 2003 15:01:29 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:22220 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S261768AbTDBUB3>;
	Wed, 2 Apr 2003 15:01:29 -0500
Date: Wed, 2 Apr 2003 22:12:43 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Art Haas <ahaas@airmail.net>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [PATCH] C99 initializers for sound/oss/dmasound
In-Reply-To: <20030402151249.GD22242@debian>
Message-ID: <Pine.GSO.4.21.0304022211390.23156-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Apr 2003, Art Haas wrote:
> Here is a set of patches for files in that directory to convert the
> files to use C99 initializers. The patches are against the current BK.
> 
> Art Haas
> 
> ===== sound/oss/dmasound/dmasound_atari.c 1.7 vs edited =====
> --- 1.7/sound/oss/dmasound/dmasound_atari.c	Sat Sep 28 20:38:50 2002
> +++ edited/sound/oss/dmasound/dmasound_atari.c	Wed Feb 26 18:33:00 2003

Thanks!

BTW, I just noticed those files never get compiled, although I have all m68k
dmasound drivers enabled in my .config. Does the same thing happen on PPC?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

