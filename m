Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266271AbUJRJxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266271AbUJRJxb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 05:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266175AbUJRJvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 05:51:54 -0400
Received: from witte.sonytel.be ([80.88.33.193]:59587 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265795AbUJRJqA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 05:46:00 -0400
Date: Mon, 18 Oct 2004 11:45:50 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jim Nelson <james4765@verizon.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Patch to drivers/video/Kconfig [4 of 4]
In-Reply-To: <41738EF2.3030701@verizon.net>
Message-ID: <Pine.GSO.4.61.0410181145090.23486@waterleaf.sonytel.be>
References: <41738EF2.3030701@verizon.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2004, Jim Nelson wrote:
> Fix undefined symbol errors in "make config" on architectures that do
> not have I2C (sparc, primarily)

Why doesn't SPARC have i2c? If it has PCI and nVidia (and some other) graphics
cards, it has i2c.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
