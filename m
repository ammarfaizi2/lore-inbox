Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265269AbUFTR4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265269AbUFTR4T (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 13:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265285AbUFTR4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 13:56:17 -0400
Received: from main.gmane.org ([80.91.224.249]:49806 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265907AbUFTRz5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 13:55:57 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: Framebuffer with nVidia GeForce 2 Go on Dell Inspiron 8200
Date: Sun, 20 Jun 2004 19:55:13 +0200
Message-ID: <MPG.1b3fedefb4f707089896ce@news.gmane.org>
References: <MPG.1ac04509fe5b83d7989685@news.gmane.org> <Pine.LNX.4.44.0403172149140.19415-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ppp-59-141.29-151.libero.it
X-Newsreader: MicroPlanet Gravity v2.60
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
> > >From rivafb:
> > ===
> > rivafb: nVidia device/chipset 10DE0112
> > rivafb: On a laptop.  Assuming Digital Flat Panel
> > rivafb: Detected CRTC controller 1 being used
> > rivafb: RIVA MTRR set to ON
> > rivafb: PCI nVidia NV10 framebuffer ver 0.9.5b (nVidiaGeForce2-G, 
> > 32MB @ 0xE0000000) 
> > ===
> > 
> > In this case, fbset -i returns (well, doesn't because the screen goes 
> > black, but the computer is still fully functional):

James Simmons replied:

> That a bug I have to work. I have a newer driver but I need to run more 
> test.

Any news on this? I tried 2.6.7, which has the EDID patch from 
Guido included, but I still have this error ...

-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)

