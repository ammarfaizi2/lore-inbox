Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261764AbVG1UJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbVG1UJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 16:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbVG1UHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 16:07:21 -0400
Received: from witte.sonytel.be ([80.88.33.193]:33945 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261777AbVG1UE7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 16:04:59 -0400
Date: Thu, 28 Jul 2005 22:04:28 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jon Smirl <jonsmirl@gmail.com>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [PATCH] fbdev: colormap fixes
In-Reply-To: <9e473391050728123150931cbd@mail.gmail.com>
Message-ID: <Pine.LNX.4.62.0507282204040.29876@numbat.sonytel.be>
References: <200507280031.j6S0V3L3016861@hera.kernel.org> 
 <Pine.LNX.4.62.0507280952140.24391@numbat.sonytel.be> 
 <9e473391050728074573e40038@mail.gmail.com> <9e473391050728123150931cbd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jul 2005, Jon Smirl wrote:
> Do we want to apply this patch now to get rid of the buffer overflow hole?

IMHO, yes please.

> Then we can take our time and work out a better solution.

Indeed.

> Fix a buffer overflow vunerabilty in previous cmap patch
> signed-off-by: Jon Smirl <jonsmirl@gmail.com>

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
