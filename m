Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262514AbUC2NxG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 08:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262871AbUC2NxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 08:53:05 -0500
Received: from witte.sonytel.be ([80.88.33.193]:35008 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262514AbUC2Nw7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 08:52:59 -0500
Date: Mon, 29 Mar 2004 15:52:53 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Joey Parrish <joey@nicewarrior.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] no Walken during fb boot
In-Reply-To: <20040328174718.GA12681@nicewarrior.org>
Message-ID: <Pine.GSO.4.58.0403291551450.19888@waterleaf.sonytel.be>
References: <20040328174718.GA12681@nicewarrior.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Mar 2004, Joey Parrish wrote:
> I've noticed a bug in the fb system during boot.  (I'm running a
> stock 2.6.4 kernel, with the newer of the two radeonfb drivers
> compiled in statically.)  After the fb driver initializes, there
> is _never_ a boot logo featuring star of stage and screen,
> Mr. Christopher Walken.
>
> Included below is a patch to fix this issue.  (gzip'd, ~24kb)

Please supply walken.ppm instead of walken.c ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
