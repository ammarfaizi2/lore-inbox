Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262271AbVCILi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262271AbVCILi4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 06:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262292AbVCILiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 06:38:55 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:18144 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262271AbVCILiy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 06:38:54 -0500
Date: Wed, 9 Mar 2005 12:38:42 +0100
From: Pavel Machek <pavel@ucw.cz>
To: James Simmons <jsimmons@www.infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] [announce 0/7] fbsplash - The Framebuffer Splash
Message-ID: <20050309113842.GB30119@elf.ucw.cz>
References: <20050308015731.GA26249@spock.one.pl> <Pine.LNX.4.56.0503081945510.15646@pentafluge.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0503081945510.15646@pentafluge.infradead.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Fbsplash - The Framebuffer Splash - is a feature that allows displaying
> > images in the background of consoles that use fbcon. The project is
> > partially descended from bootsplash. 
> 
> What are you trying to do exactly? I really don't see the point of this 
> patch.

At least some Debians, Gentoo and SUSE each use some variant of this
eye candy; each one with different bugs. It would be nice to at least
do the splash right (so that it does not require vesafb and therefore
allows working with suspend-to-RAM).
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
