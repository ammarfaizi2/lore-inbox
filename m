Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbUCQXGG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 18:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbUCQXGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 18:06:05 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:32260 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262133AbUCQXGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 18:06:03 -0500
Date: Wed, 17 Mar 2004 23:06:01 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Giuseppe Bilotta <bilotta78@hotpop.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Framebuffer with nVidia GeForce 2 Go on Dell Inspiron 8200
In-Reply-To: <MPG.1ac2f3b3ae2e948c989687@news.gmane.org>
Message-ID: <Pine.LNX.4.44.0403172303070.19415-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I need to add more info to the docs on what modes are supported. 
> > 	1600x1200		
> > 	---------
> > 256	0x119	  0x145	
> > 32K	0x11D	  0x146
> > 64K	0x11E
> > 16M		  0x14E
> > 
> > For lilo translate them to decimal number. I'm curious if the 14X numbers 
> > work.
> 
> I guess I would have to input 31e or 34e at the vga=ask prompt, 
> right? Well, I never managed to get a code with letters to work :( I 
> will try again ...

No. vga = 793
	= 797
	= 798
 
Give those a try.

> If you want, I can try and test it on my computer too (if you can 
> guarantee it doesn't format my hard drive and give my syphilis ;))

Nah. I'm working on those bugs.


