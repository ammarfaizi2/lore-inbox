Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261727AbVC1NWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbVC1NWa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 08:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261737AbVC1NWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 08:22:30 -0500
Received: from witte.sonytel.be ([80.88.33.193]:3558 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261727AbVC1NW0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 08:22:26 -0500
Date: Mon, 28 Mar 2005 15:14:04 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Aaron Gyes <floam@sh.nu>
cc: Adrian Bunk <bunk@stusta.de>,
       "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
In-Reply-To: <1111951014.9831.4.camel@localhost>
Message-ID: <Pine.LNX.4.62.0503281513100.7244@numbat.sonytel.be>
References: <1111886147.1495.3.camel@localhost> <490243b66dc7c3f592df7a7d0769dcb7@mac.com>
 <1111913399.6297.28.camel@laptopd505.fenrus.org> <16d78e9ea33380a1f1ad90c454fb6e1d@mac.com>
 <20050327180417.GD3815@gallifrey>  <20050327183522.GM4285@stusta.de>
 <1111951014.9831.4.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Mar 2005, Aaron Gyes wrote:
> > And then the user want to upgrade the 2.0 kernel that shipped with this 
> > box although the company that made the hardware went bankrupt some years 
> > ago.
> > 
> > If the user has the source of the driver, he can port the driver or hire 
> > someone to port the driver (this "obscure piece of hardware" might also 
> > be an expensive piece of hardware).
> 
> So what? Sure, GPL'd drivers are easier for an end-user in that case.
> What does that have to do with law? What about what's better for the
> company that made the device? Should NVIDIA be forced to give up their
> secrets to all their competitors because some over zealous developers
                                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> say so? Should the end-users of the current drivers be forced to lose
  ^^^^^^^
> out on features such as sysfs and udev compatability?

Because otherwise they are violating someone else's copyright?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
