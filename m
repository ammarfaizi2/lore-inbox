Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267283AbUIETrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267283AbUIETrA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 15:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267209AbUIETq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 15:46:59 -0400
Received: from witte.sonytel.be ([80.88.33.193]:27265 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S267176AbUIETob (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 15:44:31 -0400
Date: Sun, 5 Sep 2004 21:44:29 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] abstract thread_info access
In-Reply-To: <Pine.LNX.4.61.0409052112190.9677@scrub.home>
Message-ID: <Pine.GSO.4.58.0409052143590.6942@waterleaf.sonytel.be>
References: <Pine.LNX.4.61.0409052112190.9677@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Sep 2004, Roman Zippel wrote:
> diff -ur linux-2.6.8.1-allocstack/include/asm/i387.h linux-2.6.8.1-getthreadinfo/include/asm/i387.h

Woops, you forgot to filter out the include/asm/ files.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
