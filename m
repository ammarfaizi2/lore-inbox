Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbVIFOui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbVIFOui (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 10:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750703AbVIFOui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 10:50:38 -0400
Received: from witte.sonytel.be ([80.88.33.193]:25584 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1750702AbVIFOui (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 10:50:38 -0400
Date: Tue, 6 Sep 2005 16:50:23 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: viro@ZenIV.linux.org.uk
cc: Roman Zippel <zippel@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Kconfig fix (BLK_DEV_FD dependencies)
In-Reply-To: <20050906134944.GV5155@ZenIV.linux.org.uk>
Message-ID: <Pine.LNX.4.62.0509061649330.20769@numbat.sonytel.be>
References: <20050906004842.GP5155@ZenIV.linux.org.uk>
 <Pine.LNX.4.61.0509061205510.3743@scrub.home> <20050906134944.GV5155@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Sep 2005 viro@ZenIV.linux.org.uk wrote:
> 	* the same is true for subarchitectures of arm/mips/ppc - hell, even
> for m68k, except that there we don't get new ones.

I wouldn't count on that... Coldfire with MMU, where are you? ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
