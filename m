Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbUCQX16 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 18:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbUCQX16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 18:27:58 -0500
Received: from main.gmane.org ([80.91.224.249]:42890 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262170AbUCQXZs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 18:25:48 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: Framebuffer with nVidia GeForce 2 Go on Dell Inspiron 8200
Date: Thu, 18 Mar 2004 00:25:42 +0100
Message-ID: <MPG.1ac2fce1bf9b0b3e989688@news.gmane.org>
References: <MPG.1ac2f3b3ae2e948c989687@news.gmane.org> <Pine.LNX.4.44.0403172303070.19415-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ppp-171-130.29-151.libero.it
X-Newsreader: MicroPlanet Gravity v2.60
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons wrote:
> 
> > > I need to add more info to the docs on what modes are supported. 
> > > 	1600x1200		
> > > 	---------
> > > 256	0x119	  0x145	
> > > 32K	0x11D	  0x146
> > > 64K	0x11E
> > > 16M		  0x14E
> > > 
> > > For lilo translate them to decimal number. I'm curious if the 14X numbers 
> > > work.
> > 
> > I guess I would have to input 31e or 34e at the vga=ask prompt, 
> > right? Well, I never managed to get a code with letters to work :( I 
> > will try again ...
> 
> No. vga = 793
> 	= 797
> 	= 798
>  
> Give those a try.

(I was talking on the prompt I get at boot time when vga=ask :))


-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)

