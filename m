Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265647AbUA2MGM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 07:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265789AbUA2MGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 07:06:12 -0500
Received: from witte.sonytel.be ([80.88.33.193]:64159 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265647AbUA2MGL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 07:06:11 -0500
Date: Thu, 29 Jan 2004 13:06:00 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Xan <DXpublica@telefonica.net>
cc: Kiko Piris <kernel@pirispons.net>,
       Zack Winkles <winkie@linuxfromscratch.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.1] fbdev console: can't load vga=791 and yes vga=ask!
In-Reply-To: <200401280139.51712.DXpublica@telefonica.net>
Message-ID: <Pine.GSO.4.58.0401291305410.8124@waterleaf.sonytel.be>
References: <200401270153.12568.DXpublica@telefonica.net>
 <200401271859.03309.DXpublica@telefonica.net> <20040127225909.GA5271@sacarino.pirispons.net>
 <200401280139.51712.DXpublica@telefonica.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jan 2004, Xan wrote:
> It works finally. I don't know if with vesafb or with radeon, but it works.

Check /proc/fb

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
