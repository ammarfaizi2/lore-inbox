Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265093AbUHUNUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265093AbUHUNUq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 09:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265119AbUHUNUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 09:20:46 -0400
Received: from witte.sonytel.be ([80.88.33.193]:2434 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265093AbUHUNUp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 09:20:45 -0400
Date: Sat, 21 Aug 2004 15:20:37 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "'linux-fbdev-devel'" <linux-fbdev-devel@lists.sourceforge.net>
cc: "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Framebuffer drivers maintainers
In-Reply-To: <41270AD0.FE6C7970@orpatec.ch>
Message-ID: <Pine.GSO.4.58.0408211519310.58@waterleaf.sonytel.be>
References: <41270AD0.FE6C7970@orpatec.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Aug 2004, Otto Wyss wrote:
> I've now updated the framebuffer driver list and hopefully listed each
> current driver. It may not show the correct name so please suggest corrections.
>
> For each driver its maintainer should be listed possibly with its
> sourceforge.net user account in brackets. I'd like if only current
> maintainers, who really take care of their drivers, are listed and none
> who has done so in the past. Please any maintainer post a message to
> linux-fbdev-devel or tell me where I can retrieve reliable information.

I maintain amifb. This driver is not in linux-fbdev.sf.net CVS, but in
Linux/m68k CVS. It works fine in 2.4 and 2.6.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
