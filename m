Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262377AbVCITMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262377AbVCITMa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 14:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262376AbVCITM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 14:12:28 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:54410 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262301AbVCITHR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 14:07:17 -0500
Subject: Re: [Linux-fbdev-devel] [announce 0/7] fbsplash - The Framebuffer
	Splash
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Michal Januszewski <spock@gentoo.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       "Antonino A. Daplas" <adaplas@hotpop.com>
In-Reply-To: <Pine.LNX.4.62.0503091033400.22598@numbat.sonytel.be>
References: <20050308015731.GA26249@spock.one.pl>
	 <200503091301.15832.adaplas@hotpop.com>
	 <9e473391050308220218cc26a3@mail.gmail.com>
	 <Pine.LNX.4.62.0503091033400.22598@numbat.sonytel.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110392212.3116.215.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 09 Mar 2005 18:16:53 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-03-09 at 09:34, Geert Uytterhoeven wrote:
> On Wed, 9 Mar 2005, Jon Smirl wrote:
> > Another idea would be to build a console is user space. Think of it as
> > a full screen xterm. A user space console has access to full hardware
> > acceleration using the DRM interface.
> 
> Yep. And that's what Alan Cox wanted to do. Console in userspace, eye candy
> (using Porter-Duff blending) as much as you want, full UTF-8 support, ...

Jon is the origin of those ideas not me, I'm merely supporting them
providing there is still a basic kernel side console.

Alan

