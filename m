Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261514AbUJaJgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbUJaJgw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 04:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbUJaJgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 04:36:52 -0500
Received: from amsfep12-int.chello.nl ([213.46.243.18]:57689 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S261514AbUJaJgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 04:36:51 -0500
Date: Sun, 31 Oct 2004 10:36:49 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Adrian Bunk <bunk@stusta.de>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] remove duplicate includes (fwd)
In-Reply-To: <20041029214717.GW6677@stusta.de>
Message-ID: <Pine.LNX.4.61.0410311035580.24640@anakin>
References: <20041029214717.GW6677@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Oct 2004, Adrian Bunk wrote:
> Below is a patch that removes in cases where a file is included directly 
> twice in a file the second inclusion.

>  arch/m68k/q40/config.c                       |    1 -
>  drivers/char/amiserial.c                     |    1 -

Thanks! Applied.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
