Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263172AbUCSXwt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 18:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263173AbUCSXwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 18:52:49 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:17422 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263172AbUCSXwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 18:52:44 -0500
Date: Fri, 19 Mar 2004 23:52:37 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Ian Campbell <icampbell@arcom.com>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [PATCH] PXA255 LCD Driver
In-Reply-To: <20040318203638.A12978@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0403192352050.14905-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Wed, Mar 17, 2004 at 07:03:06PM +0000, James Simmons wrote:
> > behavior is struct fb_monspecs. Take a look at it in fb.h. I'm interested 
> > if I got all the needed data from the EDID about a display panel.
> 
> You're thinking too PC-centric.  You don't get EDID data with embedded
> LCD panels.  Instead, you get timing information, number of pixels per
> line, and other parameters either from a PDF or paper datasheet on the
> device.

Your right. Want I would like to know is what do you guys need!!!



