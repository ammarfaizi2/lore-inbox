Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964998AbVLMPVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964998AbVLMPVL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 10:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965000AbVLMPVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 10:21:11 -0500
Received: from witte.sonytel.be ([80.88.33.193]:30668 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S964998AbVLMPVJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 10:21:09 -0500
Date: Tue, 13 Dec 2005 16:13:09 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Christoph Lameter <clameter@engr.sgi.com>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>, ak@suse.de,
       bunk@stusta.de
Subject: Re: [PATCH] Introduce atomic_long_t and asm-generic/atomic.h
In-Reply-To: <Pine.LNX.4.62.0512121028410.14769@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.62.0512131608480.17990@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0512121028410.14769@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Dec 2005, Christoph Lameter wrote:
> Index: linux-2.6.15-rc5-mm2/include/asm-generic/atomic.h
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.15-rc5-mm2/include/asm-generic/atomic.h	2005-12-12 10:21:32.000000000 -0800
> @@ -0,0 +1,34 @@
> +#ifndef _ASM_GENERIC_ATOMIC_H
> +#define _ASM_GENERIC_ATOMIC_H 
> +/*
> + * Copyright (C) 2005 Silcon Graphics, Inc.
                         ^^^^^^^^^^^^^^^^^^^^
Deterioration of SGI?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
