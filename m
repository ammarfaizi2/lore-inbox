Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265998AbSLCVBb>; Tue, 3 Dec 2002 16:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266041AbSLCVBb>; Tue, 3 Dec 2002 16:01:31 -0500
Received: from albatross.mail.pas.earthlink.net ([207.217.120.120]:48311 "EHLO
	albatross.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S265998AbSLCVBa>; Tue, 3 Dec 2002 16:01:30 -0500
Date: Tue, 3 Dec 2002 14:01:06 -0800 (PST)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Antonino Daplas <adaplas@pol.net>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] FBDev: vga16fb port
In-Reply-To: <1038948479.1040.34.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0212031400420.10097-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I question whether thats something that belongs anywhere near the
> > kernel. Ben Pfaff wrote a fine library for vga16 hackery (BOGL) and it
> > combines very nicely with the fb driver.
> I kinda agree with this.  Most fb apps use mmap to access the
> framebuffer, so it's almost impossible to fake a linear framebuffer from
> a planar one.

Okay. Then that idea is scrapped.


