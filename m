Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264617AbSJNKHK>; Mon, 14 Oct 2002 06:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264611AbSJNKGO>; Mon, 14 Oct 2002 06:06:14 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:51899 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S264037AbSJNKFp>;
	Mon, 14 Oct 2002 06:05:45 -0400
Date: Mon, 14 Oct 2002 12:10:26 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: James Simmons <jsimmons@infradead.org>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCHS] fbdev updates.
In-Reply-To: <Pine.LNX.4.33.0210131332180.5997-100000@maxwell.earthlink.net>
Message-ID: <Pine.GSO.4.21.0210141209590.9580-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Oct 2002, James Simmons wrote:
> This is nearly the last of the fbdev api changes (90% of them). Alot of
> driver fixes as well. The console related stuff in each fbdev driver
> is nearly gone!!! Please do a pull. Thank you.
> 
> bk://fbdev.bkbits.net/fbdev-2.5

Please add the output of diffstat, so we know which files you changed.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

