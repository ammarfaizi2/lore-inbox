Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262589AbUBZBLg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 20:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262592AbUBZBLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 20:11:36 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:31495 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262589AbUBZBLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 20:11:34 -0500
Date: Thu, 26 Feb 2004 01:11:30 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Otto Solares <solca@guug.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] fbdv/fbcon pending problems
In-Reply-To: <1077755580.22232.89.camel@gaston>
Message-ID: <Pine.LNX.4.44.0402260045040.24952-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Note that I am NOT talking about a graphics library. This has NO
> BUSINESS doing any kind of rendering. It's only the userland interface
> to the underlying kernel drivers as far as mode switching & geometry
> is concerned. That's _ALL_. In the same  was as libGL is the userland
> interface to DRI, or iptables the userlnad interface to netfilter,
> etc...
..snip..

That cool. Sorry, email is so limited sometimes in details. I agree with 
you 100%.
  
> > I think we are fine for whats in the kernel. As for multiple head and 
> > geometry stuff its not that hard if done right. I have been using 
> > multi-head systems for years. I have multip desktop systems for years!!!
> 
> I have been using multi head systems for years and I've seen how good
> it can be, but also a bunch of the pitfalls when trying to design a
> driver for it. If it was that easy, we would have had the right support
> in fbdev for ages. We don't.

True it is not to easy but I have worked on it. I'm glad to see the input 
api and most of the fbdev stfuff go in. It laid down the need foundation 
for mulitdesktop systems.



