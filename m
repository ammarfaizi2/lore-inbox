Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262439AbVCIV3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbVCIV3V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 16:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262267AbVCIVZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 16:25:37 -0500
Received: from witte.sonytel.be ([80.88.33.193]:18623 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262445AbVCIUeO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 15:34:14 -0500
Date: Wed, 9 Mar 2005 21:33:44 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Michal Januszewski <spock@gentoo.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [Linux-fbdev-devel] [announce 0/7] fbsplash - The Framebuffer
 Splash
In-Reply-To: <1110392212.3116.215.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0503092133300.8551@numbat.sonytel.be>
References: <20050308015731.GA26249@spock.one.pl> <200503091301.15832.adaplas@hotpop.com>
 <9e473391050308220218cc26a3@mail.gmail.com> <Pine.LNX.4.62.0503091033400.22598@numbat.sonytel.be>
 <1110392212.3116.215.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Mar 2005, Alan Cox wrote:
> On Mer, 2005-03-09 at 09:34, Geert Uytterhoeven wrote:
> > On Wed, 9 Mar 2005, Jon Smirl wrote:
> > > Another idea would be to build a console is user space. Think of it as
> > > a full screen xterm. A user space console has access to full hardware
> > > acceleration using the DRM interface.
> > 
> > Yep. And that's what Alan Cox wanted to do. Console in userspace, eye candy
> > (using Porter-Duff blending) as much as you want, full UTF-8 support, ...
> 
> Jon is the origin of those ideas not me, I'm merely supporting them
> providing there is still a basic kernel side console.

Thanks for correcting me!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
