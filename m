Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267746AbUJOMlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267746AbUJOMlQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 08:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267751AbUJOMjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 08:39:25 -0400
Received: from witte.sonytel.be ([80.88.33.193]:7160 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S267746AbUJOMiI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 08:38:08 -0400
Date: Fri, 15 Oct 2004 14:38:01 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       penguinppc-team@lists.penguinppc.org
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video
 card BOOT?
In-Reply-To: <87d5zkqj8h.fsf@bytesex.org>
Message-ID: <Pine.GSO.4.61.0410151437050.10040@waterleaf.sonytel.be>
References: <416E6ADC.3007.294DF20D@localhost> <87d5zkqj8h.fsf@bytesex.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Oct 2004, Gerd Knorr wrote:
> Have you talked to the powermanagement guys btw.?  One of the major
> issues with suspend-to-ram is to get the graphics card back online,
> and SNAPBoot might help to fix this too.  I'm not sure a userspace
> solution would work for *that* through.

Why not? Of course you won't get any output before the graphics card has been
re-initialized to a sane and usable state...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
