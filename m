Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbTIKPcM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 11:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261371AbTIKPcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 11:32:12 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:25744 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261370AbTIKPcJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 11:32:09 -0400
Date: Thu, 11 Sep 2003 17:32:06 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marek Szyprowski <march@staszic.waw.pl>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASFS filesystem patch, kernel 2.4.21
In-Reply-To: <yam9384.2177.1200381112@boss.staszic.waw.pl>
Message-ID: <Pine.GSO.4.21.0309111730550.1879-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Sep 2003, Marek Szyprowski wrote:
> This patch adds read-only support for Amiga SmartFileSystem. This filesystem
> is being used very commonly on AmigaOS and MorphOS systems. This patch has
> been tested on Linux/PPC, Linux/m68k and Linux/x86 machines. This patch is
> prepared for kernel 2.4.21.

ASFS is happily living in the Linux/m68k CVS tree as well.

However, I guess Marcelo will insist you port it to 2.6.0 first, before it will
be accepted in the mainline.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

