Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261365AbVFMVRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbVFMVRa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 17:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbVFMVPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 17:15:51 -0400
Received: from witte.sonytel.be ([80.88.33.193]:24798 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261365AbVFMVOI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 17:14:08 -0400
Date: Mon, 13 Jun 2005 23:13:50 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: randy_dunlap <rdunlap@xenotime.net>
cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [PATCH] macmodes: needs a license
In-Reply-To: <20050613123441.56721c61.rdunlap@xenotime.net>
Message-ID: <Pine.LNX.4.62.0506132313180.27959@numbat.sonytel.be>
References: <20050613123441.56721c61.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jun 2005, randy_dunlap wrote:
> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> Module needs a license to prevent kernel tainting.
> 
> Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>

Ack'ed by Geert Uytterhoeven <geert@linux-m68k.org>

> diffstat:=
>  drivers/video/macmodes.c |    1 +
>  1 files changed, 1 insertion(+)
> 
> diff -Naurp ./drivers/video/macmodes.c~taint_video ./drivers/video/macmodes.c
> --- ./drivers/video/macmodes.c~taint_video	2005-06-10 18:41:17.000000000 -0700
> +++ ./drivers/video/macmodes.c	2005-06-13 10:30:59.000000000 -0700
> @@ -387,3 +387,4 @@ int __init mac_find_mode(struct fb_var_s
>  }
>  EXPORT_SYMBOL(mac_find_mode);
>  
> +MODULE_LICENSE("GPL");

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
