Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbUCQLFq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 06:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbUCQLFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 06:05:46 -0500
Received: from webapps.arcom.com ([194.200.159.168]:52485 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S261322AbUCQLFo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 06:05:44 -0500
Subject: Re: [PATCH] PXA255 LCD Driver
From: Ian Campbell <icampbell@arcom.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       James Simmons <jsimmons@infradead.org>
In-Reply-To: <Pine.GSO.4.58.0403171137410.21104@waterleaf.sonytel.be>
References: <1079518182.13373.27.camel@icampbell-debian>
	 <Pine.GSO.4.58.0403171137410.21104@waterleaf.sonytel.be>
Content-Type: text/plain
Organization: Arcom Control Systems
Message-Id: <1079521633.13370.39.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 17 Mar 2004 11:07:14 +0000
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Mar 2004 11:10:06.0375 (UTC) FILETIME=[6734F370:01C40C10]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > +For example:
> > +	modprobe pxafb options=xres:640,yres:480,bpp:8,passive
> 
> Not much comments, except: why don't you use the standard modedb mode parameter
> style?

I was trying too (I mostly copied the i810 driver). How wrong did I get
it? I'm willing to rework it to make it the same as the standard.

> > I posted it to the fbdev list @ sf.net (from MAINTAINERS) but that list
> > seems to be pretty quiet and www.linux-fbdev.org (also from MAINTAINERS)
> 
> It's not quiet, though.

OK, I just hadn't seen many messages since I subscribed...

Ian.

-- 
Ian Campbell, Senior Design Engineer
                                        Web: http://www.arcom.com
Arcom, Clifton Road, 			Direct: +44 (0)1223 403 465
Cambridge CB1 7EA, United Kingdom	Phone:  +44 (0)1223 411 200

