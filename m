Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266115AbUHMPfH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266115AbUHMPfH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 11:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266127AbUHMPfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 11:35:01 -0400
Received: from witte.sonytel.be ([80.88.33.193]:21224 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S266009AbUHMPef (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 11:34:35 -0400
Date: Fri, 13 Aug 2004 17:34:34 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: =?iso-8859-1?q?Zhan=20Rongkai?= <zhanrk2000@yahoo.com.au>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: About the decompression of compressed kernel image
In-Reply-To: <20040813145649.99935.qmail@web61309.mail.yahoo.com>
Message-ID: <Pine.GSO.4.58.0408131732510.28832@waterleaf.sonytel.be>
References: <20040813145649.99935.qmail@web61309.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Aug 2004, [iso-8859-1] Zhan Rongkai wrote:
> I am porting linux-2.6.4 to a new architecture

Which one?

> 'arch/$(ARCH)/boot/compressed/vmlinux.bin'

>  * linux/arch/frvnommu/boot/compressed/vmlinux.lds.in
                ^^^^^^^^
IC, you forgot to obfuscate one occurrence :-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
