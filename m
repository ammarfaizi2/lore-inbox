Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266539AbUIFNxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266539AbUIFNxF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 09:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268020AbUIFNxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 09:53:05 -0400
Received: from witte.sonytel.be ([80.88.33.193]:27387 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S266539AbUIFNwt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 09:52:49 -0400
Date: Mon, 6 Sep 2004 15:52:30 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
cc: takata@linux-m32r.org, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: EXPORT_SYMBOL_NOVERS (was: Re: 2.6.9-rc1-mm3)
In-Reply-To: <Pine.LNX.4.58.0409030823530.4481@montezuma.fsmlabs.com>
Message-ID: <Pine.GSO.4.58.0409061539270.17329@waterleaf.sonytel.be>
References: <20040903014811.6247d47d.akpm@osdl.org> <20040903104239.A3077@infradead.org>
 <Pine.LNX.4.58.0409030814100.4481@montezuma.fsmlabs.com>
 <Pine.LNX.4.58.0409030823530.4481@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Sep 2004, Zwane Mwaikambo wrote:
> - arch/m32r/kernel/m32r_ksyms, EXPORT_SYMBOL_NOVERS is deprecated, use
>   EXPORT_SYMBOL.

Hint for the kernel janitors? I've just counted +300 of them...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
