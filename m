Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261574AbUCBJa3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 04:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbUCBJa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 04:30:29 -0500
Received: from witte.sonytel.be ([80.88.33.193]:56246 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261574AbUCBJa1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 04:30:27 -0500
Date: Tue, 2 Mar 2004 10:30:12 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Hirokazu Takata <takata@linux-m32r.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] m32r - New architecure port to Renesas M32R processor 
In-Reply-To: <20040302.165524.774041887.takata.hirokazu@renesas.com>
Message-ID: <Pine.GSO.4.58.0403021028220.9959@waterleaf.sonytel.be>
References: <20040302.165524.774041887.takata.hirokazu@renesas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Mar 2004, Hirokazu Takata wrote:
> We have ported Linux to the M32R processor, which is a 32-bit RISC embedded
> microprocessor of Renesas Technology.
>
> I would like to release a patch information for this m32r port.

Nice!

> Would you merge them to the stock kernel?
> # Unfortunately, I have linux-2.4.19 based kernel, not latest one.

However, I think you best upgrade to 2.4.25 first.
Also, please merge/move arch/m32r/drivers with/to drivers/.

And what about a 2.6 port? :-)

> This new architecture port has already reported at OLS2003.
> http://www.linux-m32r.org/cmn/m32r/ols2003_presentation.pdf
> http://archive.linuxsymposium.org/ols2003/Proceedings/All-Reprints/Reprint-Takata-OLS2003.pdf

I attended that one, and it looked quite nice!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
