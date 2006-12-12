Return-Path: <linux-kernel-owner+w=401wt.eu-S1751501AbWLLQ1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbWLLQ1k (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 11:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751504AbWLLQ1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 11:27:39 -0500
Received: from vervifontaine.sonytel.be ([80.88.33.193]:50040 "EHLO
	vervifontaine.sonycom.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751501AbWLLQ1i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 11:27:38 -0500
Date: Tue, 12 Dec 2006 17:27:31 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Adrian Bunk <bunk@stusta.de>
cc: Andrew Morton <akpm@osdl.org>, funaho@jurai.org,
       Roman Zippel <zippel@linux-m68k.org>, linux-m68k@vger.kernel.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] remove the broken BLK_DEV_SWIM_IOP driver
In-Reply-To: <20061212162249.GT28443@stusta.de>
Message-ID: <Pine.LNX.4.62.0612121727180.20902@pademelon.sonytel.be>
References: <20061212162249.GT28443@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2006, Adrian Bunk wrote:
> The BLK_DEV_SWIM_IOP driver has:
> - already been marked as BROKEN in 2.6.0 three years ago and
> - is still marked as BROKEN.
> 
> Drivers that had been marked as BROKEN for such a long time seem to be
> unlikely to be revived in the forseeable future.
> 
> But if anyone wants to ever revive this driver, the code is still
> present in the older kernel releases.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
