Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262204AbVCIXOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262204AbVCIXOE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 18:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261652AbVCIXNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 18:13:00 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:7305 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262204AbVCIWr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 17:47:58 -0500
Date: Wed, 9 Mar 2005 22:47:56 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: James Simmons <jsimmons@pentafluge.infradead.org>,
       linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] [announce 0/7] fbsplash - The Framebuffer Splash
Message-ID: <20050309224756.GA10259@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pavel Machek <pavel@ucw.cz>,
	James Simmons <jsimmons@www.infradead.org>,
	linux-fbdev-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20050308015731.GA26249@spock.one.pl> <Pine.LNX.4.56.0503081945510.15646@pentafluge.infradead.org> <20050309113842.GB30119@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050309113842.GB30119@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 12:38:42PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > Fbsplash - The Framebuffer Splash - is a feature that allows displaying
> > > images in the background of consoles that use fbcon. The project is
> > > partially descended from bootsplash. 
> > 
> > What are you trying to do exactly? I really don't see the point of this 
> > patch.
> 
> At least some Debians,

While there might be a kernel-patch-bootsplash package in Debian none of
the shipped binary kernels use this.

And there's a kernel-patch- package for just about every piece of random
junk.
