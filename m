Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261640AbVCOUod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbVCOUod (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 15:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbVCOUkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 15:40:40 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:31953 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261878AbVCOUjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 15:39:05 -0500
Subject: Re: [Linux-fbdev-devel] [announce 0/7] fbsplash - The Framebuffer
	Splash
From: Lee Revell <rlrevell@joe-job.com>
To: James Simmons <jsimmons@www.infradead.org>
Cc: Jon Smirl <jonsmirl@gmail.com>, linux-fbdev-devel@lists.sourceforge.net,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       James Simmons <jsimmons@pentafluge.infradead.org>,
       Michal Januszewski <spock@gentoo.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       "Antonino A. Daplas" <adaplas@hotpop.com>
In-Reply-To: <Pine.LNX.4.56.0503151855430.5506@pentafluge.infradead.org>
References: <20050308015731.GA26249@spock.one.pl>
	 <200503091301.15832.adaplas@hotpop.com>
	 <9e473391050308220218cc26a3@mail.gmail.com>
	 <Pine.LNX.4.62.0503091033400.22598@numbat.sonytel.be>
	 <1110392212.3116.215.camel@localhost.localdomain>
	 <Pine.LNX.4.56.0503092043380.7510@pentafluge.infradead.org>
	 <1110408049.9942.275.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0503101009240.9227@numbat.sonytel.be>
	 <20050310145419.GD632@openzaurus.ucw.cz>
	 <Pine.LNX.4.56.0503111801550.10827@pentafluge.infradead.org>
	 <9e473391050311101356536667@mail.gmail.com>
	 <Pine.LNX.4.56.0503151855430.5506@pentafluge.infradead.org>
Content-Type: text/plain
Date: Tue, 15 Mar 2005 15:39:01 -0500
Message-Id: <1110919142.17931.25.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-15 at 18:58 +0000, James Simmons wrote:
> Not every device has a 3D core!!! DRM is not the answer for the entire graphics
> world. Its only for 3D functionality.

Not quite.  It's also to support hardware accelerated MPEG like on the
Unichrome boards.

Lee

