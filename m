Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbVHLHke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbVHLHke (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 03:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbVHLHke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 03:40:34 -0400
Received: from witte.sonytel.be ([80.88.33.193]:20366 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1751156AbVHLHkd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 03:40:33 -0400
Date: Fri, 12 Aug 2005 09:40:18 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] remove support for gcc < 3.2
In-Reply-To: <20050804065447.GB25606@lug-owl.de>
Message-ID: <Pine.LNX.4.62.0508120938560.18366@numbat.sonytel.be>
References: <20050731222606.GL3608@stusta.de> <21d7e99705080318347d6b58d5@mail.gmail.com>
 <20050804065447.GB25606@lug-owl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Aug 2005, Jan-Benedict Glaw wrote:
> -sh-3.00# cat cpuinfo
> cpu             : VAX
> cpu type        : KA43
> cpu sid         : 0x0b000006
> cpu sidex       : 0x04010002
> page size       : 4096
> BogoMIPS        : 10.08
> -sh-3.00# cat version
> Linux version 2.6.12 (jbglaw@d2) (gcc version 4.1.0 20050803 (experimental)) #2 Wed Aug 3 23:42:11 CEST 2005

Any change we will see this code in mainline?
Or do you wait for a 25th anniversary of your hardware, or something like that?
;-)

Gr{oetje,eeting}s,

						Geert (supporter of Linux
						       on old systems)

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
