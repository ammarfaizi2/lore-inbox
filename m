Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262538AbULOX0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbULOX0G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 18:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262534AbULOXXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 18:23:51 -0500
Received: from mail.gmx.de ([213.165.64.20]:22751 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262532AbULOXXT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 18:23:19 -0500
X-Authenticated: #20450766
Date: Thu, 16 Dec 2004 00:17:52 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Dimitris Lampridis <labis@mhl.tuc.gr>
cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PCI interrupt lost
In-Reply-To: <1103108082.3565.5.camel@naousa.mhl.tuc.gr>
Message-ID: <Pine.LNX.4.60.0412160010190.3266@poirot.grange>
References: <1102941933.3415.14.camel@naousa.mhl.tuc.gr> 
 <Pine.LNX.4.61.0412130755290.22212@montezuma.fsmlabs.com>
 <1103108082.3565.5.camel@naousa.mhl.tuc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2004, Dimitris Lampridis wrote:

> On Mon, 2004-12-13 at 07:59 -0700, Zwane Mwaikambo wrote:
> > 
> > Ps. Isn't there already a driver for that controller?
> 
> Yep, and not only one I might add... But none of them is showing the
> correct behaviour that a good driver should (in my humble opinion), and
> the best efforts are for kernels 2.4

Have you had a look at the recent work of Lothar Wassmann (and others) on 
generalisation of the OHCI driver to be used with other (including non-PCI 
connected) chips, specifically with 116x / 1362 from Philips?

If not - just browse usb-development ML archives for the last couple of 
months - you'll see lots of hits. Didn't look at the driver myself yet, 
but the reaction seems to be very positive from many USB developers

Thanks
Guennadi
---
Guennadi Liakhovetski

