Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262455AbVCIUtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262455AbVCIUtw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 15:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262466AbVCIUqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 15:46:50 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:35974 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262455AbVCIUpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 15:45:32 -0500
Date: Wed, 9 Mar 2005 20:45:22 +0000 (GMT)
From: James Simmons <jsimmons@www.infradead.org>
X-X-Sender: jsimmons@pentafluge.infradead.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Michal Januszewski <spock@gentoo.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [Linux-fbdev-devel] [announce 0/7] fbsplash - The Framebuffer
 Splash
In-Reply-To: <1110392212.3116.215.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.56.0503092043380.7510@pentafluge.infradead.org>
References: <20050308015731.GA26249@spock.one.pl>  <200503091301.15832.adaplas@hotpop.com>
  <9e473391050308220218cc26a3@mail.gmail.com>  <Pine.LNX.4.62.0503091033400.22598@numbat.sonytel.be>
 <1110392212.3116.215.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


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

Thank you. We need some kind of basic console in the kernel. I'm not the 
biggest fan of eye candy. So moving the console to userspace for eye candy 
is a dumb idea.

