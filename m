Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261905AbTJGJZx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 05:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262057AbTJGJZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 05:25:52 -0400
Received: from [80.88.36.193] ([80.88.36.193]:3475 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261905AbTJGJZw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 05:25:52 -0400
Date: Tue, 7 Oct 2003 11:25:38 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: pazke@donpac.ru
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [PATCH] visws: fix 16 bit framebuffer mode
In-Reply-To: <20031003080245.GB12930@pazke>
Message-ID: <Pine.GSO.4.21.0310071123200.2345-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Oct 2003 pazke@donpac.ru wrote:
> attached patch (from Florian Boor) allows X to work on visws 
> in 16 bit framebuffer mode.

Please also change the comment from `RGBA5551' to `ARGB1555' to match the code.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

