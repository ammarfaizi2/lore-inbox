Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261427AbVAUA0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbVAUA0J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 19:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbVAUAZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 19:25:16 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:64952 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261427AbVAUAYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 19:24:55 -0500
Date: Fri, 21 Jan 2005 00:24:43 +0000 (GMT)
From: James Simmons <jsimmons@www.infradead.org>
X-X-Sender: jsimmons@pentafluge.infradead.org
To: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
cc: Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: Radeon framebuffer weirdness in -mm2
In-Reply-To: <1106265837.18397.19.camel@gaston>
Message-ID: <Pine.LNX.4.56.0501210024010.14061@pentafluge.infradead.org>
References: <20050120232122.GF3867@waste.org>  <20050120153921.11d7c4fa.akpm@osdl.org>
  <20050120234844.GF12076@waste.org> <1106265837.18397.19.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > > I'm seeing radeonfb on my ThinkPad T30 go weird on reboot (lots of
> > > > horizontal lines) and require powercycling to fix. Worked fine with 2.6.10.
> > > 
> > > Which radeon driver? CONFIG_FB_RADEON_OLD or CONFIG_FB_RADEON?
> > 
> > FB_RADEON.
> > 
> > > (cc Ben, who is the likely cuprit ;)
> > 
> > Btw, ajoshi's address from MAINTAINERS is bouncing.
> 
> The file should be updated, I am the radeonfb maintainer now.

Speaking of. Should we nuke the old radeonfb driver?
 
