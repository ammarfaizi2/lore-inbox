Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262404AbVCIXQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262404AbVCIXQt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 18:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262527AbVCIXP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 18:15:59 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:4748 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262404AbVCIWmw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 17:42:52 -0500
Subject: Re: [Linux-fbdev-devel] [announce 0/7] fbsplash - The Framebuffer
	Splash
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: James Simmons <jsimmons@pentafluge.infradead.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Michal Januszewski <spock@gentoo.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       "Antonino A. Daplas" <adaplas@hotpop.com>
In-Reply-To: <Pine.LNX.4.56.0503092043380.7510@pentafluge.infradead.org>
References: <20050308015731.GA26249@spock.one.pl>
	 <200503091301.15832.adaplas@hotpop.com>
	 <9e473391050308220218cc26a3@mail.gmail.com>
	 <Pine.LNX.4.62.0503091033400.22598@numbat.sonytel.be>
	 <1110392212.3116.215.camel@localhost.localdomain>
	 <Pine.LNX.4.56.0503092043380.7510@pentafluge.infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110408049.9942.275.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 09 Mar 2005 22:40:50 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-03-09 at 20:45, James Simmons wrote:
> Thank you. We need some kind of basic console in the kernel. I'm not the 
> biggest fan of eye candy. So moving the console to userspace for eye candy 
> is a dumb idea.

Thats why moving the eye candy console into user space is such a good
idea. You don't have to run it 8) It also means that the console
development is accessible to all the crazy rasterman types.

