Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268718AbUHLUNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268718AbUHLUNt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 16:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268725AbUHLUNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 16:13:37 -0400
Received: from witte.sonytel.be ([80.88.33.193]:5883 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S268718AbUHLUNc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 16:13:32 -0400
Date: Thu, 12 Aug 2004 22:05:48 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Adrian Bunk <bunk@fs.tum.de>
cc: Jeff Garzik <jgarzik@pobox.com>, linux-net@vger.kernel.org,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] small Kconfig corrections for two ATARI net drivers
In-Reply-To: <20040812110615.GB13377@fs.tum.de>
Message-ID: <Pine.GSO.4.58.0408122205300.18214@waterleaf.sonytel.be>
References: <20040812110615.GB13377@fs.tum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Aug 2004, Adrian Bunk wrote:
> The patch below corrects a small problem in the dependencies of
> ATARI_BIONET and ATARI_PAMSNET (e.g. ATARI_ACSI=m shouldn't allow
> ATARI_BIONET=y).

Thanks! Applied to Linux/m68k CVS.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
