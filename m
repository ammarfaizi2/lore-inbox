Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbVLMRq2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbVLMRq2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 12:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbVLMRq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 12:46:28 -0500
Received: from witte.sonytel.be ([80.88.33.193]:29421 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S932222AbVLMRq1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 12:46:27 -0500
Date: Tue, 13 Dec 2005 18:38:36 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Adrian Bunk <bunk@stusta.de>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] defconfig's shouldn't set CONFIG_BROKEN=y
In-Reply-To: <20051213173112.GA24094@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.62.0512131837380.17990@pademelon.sonytel.be>
References: <20051211185212.GQ23349@stusta.de> <20051211192109.GA22537@flint.arm.linux.org.uk>
 <20051211193118.GR23349@stusta.de> <20051211194437.GB22537@flint.arm.linux.org.uk>
 <20051213001028.GS23349@stusta.de> <439ECDCC.80707@hogyros.de>
 <20051213140001.GG23349@stusta.de> <20051213173112.GA24094@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Dec 2005, Russell King wrote:
> If, in order to have a working platform configuration, they deem that
                         ^^^^^^^
> CONFIG_BROKEN must be enabled, then that's the way it is.
         ^^^^^^
Still funny...

So either one of them is lying...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
