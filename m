Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263521AbTJWKIW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 06:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263523AbTJWKIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 06:08:22 -0400
Received: from [80.88.36.193] ([80.88.36.193]:58047 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S263521AbTJWKIV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 06:08:21 -0400
Date: Thu, 23 Oct 2003 12:00:24 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: James Simmons <jsimmons@infradead.org>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [FBDEV UPDATE] Newer patch.
In-Reply-To: <Pine.LNX.4.44.0310221814290.25125-100000@phoenix.infradead.org>
Message-ID: <Pine.GSO.4.21.0310231200050.27218-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Oct 2003, James Simmons wrote:
>   I have a new patch against 2.6.0-test8. This patch is a few fixes and I 
> added back in functionality for switching the video mode for fbcon via 
> fbset again. Give it a try and let me know the results.
> 
> http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

This patch accidentally includes drivers/video/logo/logo_linux_clut224.c.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

