Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264268AbTEGTgV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 15:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264271AbTEGTgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 15:36:20 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:22696 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id S264270AbTEGTer (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 15:34:47 -0400
Date: Wed, 7 May 2003 21:44:08 +0200 (MEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Ben Collins <bcollins@debian.org>
cc: Linus Torvalds <torvalds@transmeta.com>,
       James Simmons <jsimmons@infradead.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.69 
In-Reply-To: <Pine.LNX.4.44.0305041739020.1737-100000@home.transmeta.com>
Message-ID: <Pine.GSO.4.21.0305072138510.12013-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 May 2003, Linus Torvalds wrote:
> Summary of changes from v2.5.68 to v2.5.69
> ============================================
> 
> Ben Collins:
>   o [VIDEO]: Revert cfbimgblt.c back to a working state on 64-bit
>   o [VIDEO]: Revert atyfb back to known working clean base

For future changes, could you please run these `reversals' through 
linux-fbdev-devel, instead of silently passing them behind our backs? Thanks!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

