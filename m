Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261529AbTADVAR>; Sat, 4 Jan 2003 16:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261545AbTADVAQ>; Sat, 4 Jan 2003 16:00:16 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:29712 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261529AbTADVAN>; Sat, 4 Jan 2003 16:00:13 -0500
Date: Sat, 4 Jan 2003 21:08:43 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Jurriaan <thunder7@xs4all.nl>
cc: Antonino Daplas <adaplas@pol.net>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][FBDEV]: fb_putcs() and fb_setfont() methods
In-Reply-To: <20030104140058.GA10918@middle.of.nowhere>
Message-ID: <Pine.LNX.4.44.0301042107390.24903-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Attached is a patch against 2.5.54 in an attempt to add putcs() and
> > setfont() methods for fbdev drivers that require them:
> > 
> And those drivers would be the matrox framebuffer drivers, for example?
> 
> That would be really great!

I'm porting this driver to the new api. I'm alomst finished with the 
nvidia driver. Once I'm done on that the matrox driver is next. Sorry it 
is taking so long but I have alot of drivers to deal with.

