Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267388AbUBSRER (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 12:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267387AbUBSREQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 12:04:16 -0500
Received: from smtp01.web.de ([217.72.192.180]:39203 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S267388AbUBSRDt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 12:03:49 -0500
Date: Thu, 19 Feb 2004 18:04:40 +0100
From: Arne Ahrend <aahrend@web.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.6: No hot_UN_plugging of PCMCIA network cards
Message-Id: <20040219180440.1a3c655d.aahrend@web.de>
In-Reply-To: <4034016C.5070307@pobox.com>
References: <20040122210501.40800ea7.aahrend@web.de>
	<20040122213757.H23535@flint.arm.linux.org.uk>
	<20040123232025.4a128ead.aahrend@web.de>
	<20040124004530.B25466@flint.arm.linux.org.uk>
	<4034016C.5070307@pobox.com>
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Feb 2004 19:21:00 -0500
Jeff Garzik <jgarzik@pobox.com> wrote:

> Russell King wrote:
> > On Fri, Jan 23, 2004 at 11:20:25PM +0100, Arne Ahrend wrote:
> > 
> >>>It works for me - with pcnet_cs.  Do you have ipv6 configured into the
> >>>kernel?
> >>
> >>No.
> > 
> > 
> > Argh, it seems that several patches which were in the netdrv experimental
> > tree never got merged.
> > 
> > Jeff - what's the situation with the net driver experimental tree?
> > Could the DEV_STALE_CONFIG patches from around December time be
> > merged please?
> 
> 
> All my netdev patches are in upstream now, FWIW.
> 
> 	Jeff
> 
> 
I have just upgraded from 2.6.3-rc2 (which was the first post 2.4 kernel to
fix the problem I had) to 2.6.3. Everything is working perfectly.
Many thanks!

	Arne
