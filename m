Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267771AbUGWPCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267771AbUGWPCJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 11:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267779AbUGWPCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 11:02:09 -0400
Received: from witte.sonytel.be ([80.88.33.193]:19184 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S267771AbUGWPCG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 11:02:06 -0400
Date: Fri, 23 Jul 2004 16:54:18 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: =?iso-8859-1?q?szonyi=20calin?= <caszonyi@yahoo.com>
cc: Paul Jackson <pj@sgi.com>, Adrian Bunk <bunk@fs.tum.de>,
       Andrew Morton <akpm@osdl.org>, corbet@lwn.net,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: New dev model (was [PATCH] delete devfs)
In-Reply-To: <20040723081637.93875.qmail@web52903.mail.yahoo.com>
Message-ID: <Pine.GSO.4.58.0407231652050.9434@waterleaf.sonytel.be>
References: <20040723081637.93875.qmail@web52903.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jul 2004, [iso-8859-1] szonyi calin wrote:
> And with new devepment model this expenses will be passed to the
> end user when the kernel will not be stable enough and will
>  crash. Do you you remember the 8k vs 4k stack problem for
> Nvidia binary kernel module ?

You want a stable kernel, but you also want to rely on binary-only kernel
modules?

The Linux kernel people cannot guarantee stability with binary-only kernel
modules. And the Linux kernel people cannot solve that problem...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
