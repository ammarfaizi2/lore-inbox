Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262068AbUJYQoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbUJYQoP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 12:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbUJYQgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 12:36:17 -0400
Received: from denise.shiny.it ([194.20.232.1]:22936 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id S262037AbUJYQco (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 12:32:44 -0400
Date: Mon, 25 Oct 2004 18:32:27 +0200 (CEST)
From: Giuliano Pochini <pochini@denise.shiny.it>
To: Timothy Miller <miller@techsource.com>
cc: Tonnerre <tonnerre@thundrix.ch>, Helge Hafting <helgehaf@aitel.hist.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
In-Reply-To: <417D216D.1060206@techsource.com>
Message-ID: <Pine.LNX.4.58.0410251825480.16966@denise.shiny.it>
References: <4176E08B.2050706@techsource.com> <1098442636l.17554l.0l@hh>
 <20041025152921.GA25154@thundrix.ch> <417D216D.1060206@techsource.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 Oct 2004, Timothy Miller wrote:

>
>
> Tonnerre wrote:
> > Salut,
> >
> > On Fri, Oct 22, 2004 at 10:57:16AM +0000, Helge Hafting wrote:
> >
> >>24-bit color
> >>------------
> >
> >
> > Why don't you use 32-bit colors?  24-bit packed pixels are a pita, and
> > a lot of OpenGL hardware doesn't support 24bpp. You might atcually get
> > better graphics/performance/etc. if you  stick to 32bpp. Only that the
> > framebuffer size increases by 1/3rd.
>
> It's been ages since I've encountered a GPU which could do packed 24.  I
> think when people talk about "24 bit color", they're also thinking "32
> bits per pixel".  Besides, there's the alpha channel.

Well, in order to save memory and bandwidth, the data can be 24bpp, but
the software sees it 32bpp.

I didn't follow the whole thread, but IMHO the most important thing is 2D.
If you like gaming, a slow 3D card is useless. I would prefer a card with
excellent 2D features instead.


--
Giuliano.
