Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935644AbWLCKrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935644AbWLCKrY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 05:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935788AbWLCKrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 05:47:24 -0500
Received: from vervifontaine.sonytel.be ([80.88.33.193]:25790 "EHLO
	vervifontaine.sonycom.com") by vger.kernel.org with ESMTP
	id S935644AbWLCKrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 05:47:23 -0500
Date: Sun, 3 Dec 2006 11:47:19 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Adrian Bunk <bunk@stusta.de>
cc: Sam Creasey <sammy@sammy.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: MAINTAINERS: remove the non-existing sun3 list
In-Reply-To: <20061201115818.GX11084@stusta.de>
Message-ID: <Pine.LNX.4.62.0612031146200.20605@pademelon.sonytel.be>
References: <20061201115818.GX11084@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Dec 2006, Adrian Bunk wrote:
> sun3-list@redhat.com does no longer exist.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.19-rc6-mm2/MAINTAINERS.old	2006-12-01 12:56:19.000000000 +0100
> +++ linux-2.6.19-rc6-mm2/MAINTAINERS	2006-12-01 12:56:39.000000000 +0100
> @@ -2994,7 +2994,6 @@
>  SUN3/3X
>  P:	Sam Creasey
>  M:	sammy@sammy.net
> -L:	sun3-list@redhat.com
>  W:	http://sammy.net/sun3/
>  S:	Maintained

Please replace broken m68k port lists with linux-m68k@lists.linux-m68k.org.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
