Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263145AbVCJVUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263145AbVCJVUz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 16:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263147AbVCJVUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 16:20:55 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:61134 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263145AbVCJVUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 16:20:40 -0500
Date: Thu, 10 Mar 2005 15:54:20 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       James Simmons <jsimmons@pentafluge.infradead.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Michal Januszewski <spock@gentoo.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [Linux-fbdev-devel] [announce 0/7] fbsplash - The Framebuffer Splash
Message-ID: <20050310145419.GD632@openzaurus.ucw.cz>
References: <20050308015731.GA26249@spock.one.pl> <200503091301.15832.adaplas@hotpop.com> <9e473391050308220218cc26a3@mail.gmail.com> <Pine.LNX.4.62.0503091033400.22598@numbat.sonytel.be> <1110392212.3116.215.camel@localhost.localdomain> <Pine.LNX.4.56.0503092043380.7510@pentafluge.infradead.org> <1110408049.9942.275.camel@localhost.localdomain> <Pine.LNX.4.62.0503101009240.9227@numbat.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0503101009240.9227@numbat.sonytel.be>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Thank you. We need some kind of basic console in the kernel. I'm not the 
> > > biggest fan of eye candy. So moving the console to userspace for eye candy 
> > > is a dumb idea.
> > 
> > Thats why moving the eye candy console into user space is such a good
> > idea. You don't have to run it 8) It also means that the console
> > development is accessible to all the crazy rasterman types.
> 
> Yep. The basic console we already have. Everyone who wants eye candy can switch
> from basic console to user space console in early userspace.
> 

Heh, I'm afraid it does not work like that. Anyone who wants eye-candy
simply applies broken patch to their kernel... unless their distribution applied one
already.

Situation where we have one working eye-candy patch would certainly
be an improvement.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

