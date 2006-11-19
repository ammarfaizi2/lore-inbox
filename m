Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756585AbWKSLqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756585AbWKSLqq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 06:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756584AbWKSLqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 06:46:46 -0500
Received: from vervifontaine.sonytel.be ([80.88.33.193]:4278 "EHLO
	vervifontaine.sonycom.com") by vger.kernel.org with ESMTP
	id S1756585AbWKSLqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 06:46:45 -0500
Date: Sun, 19 Nov 2006 12:46:41 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Adrian Bunk <bunk@stusta.de>
cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>, adaplas@pol.net,
       James Simmons <jsimmons@infradead.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Roman Zippel <zippel@linux-m68k.org>, linux-m68k@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] remove broken video drivers
In-Reply-To: <20061118195519.GZ31879@stusta.de>
Message-ID: <Pine.LNX.4.62.0611191246150.31733@pademelon.sonytel.be>
References: <20061118000235.GV31879@stusta.de>
 <Pine.LNX.4.58.0611181132230.7667@xplor.biophys.uni-duesseldorf.de>
 <20061118195519.GZ31879@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Nov 2006, Adrian Bunk wrote:
> On Sat, Nov 18, 2006 at 11:34:41AM +0100, Michael Schmitz wrote:
> > On Sat, 18 Nov 2006, Adrian Bunk wrote:
> Are any of the following Atari options that are also on my
> "BROKEN since at least 2.6.0" list also being revived?
> 
> - HADES (arch/m68k/Kconfig)
> - ATARI_ACSI (drivers/net/Kconfig)
> - ATARI_BIONET (drivers/net/Kconfig)
> - ATARI_PAMSNET (drivers/net/Kconfig)
> - ATARI_SCSI (drivers/scsi/Kconfig)

AFAIK, Michael is also working on ATARI_SCSI.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
