Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263637AbTLXO1l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 09:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263638AbTLXO1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 09:27:41 -0500
Received: from iron-c-2.tiscali.it ([212.123.84.82]:5997 "EHLO
	mailr-2.tiscali.it") by vger.kernel.org with ESMTP id S263637AbTLXO1H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 09:27:07 -0500
X-BrightmailFiltered: true
Date: Wed, 24 Dec 2003 15:27:17 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] sysfs class patches - take 2 [0/5]
Message-ID: <20031224142717.GA3133@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031223220707.GC15946@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> ha scritto:
> > On Tue, Dec 23, 2003 at 04:57:56PM -0500, Jeff Garzik wrote:
> > Interesting...  I bet that will be useful to the iPAQ folks (I've been 
> > wading through their patches lately), as they have created a couple 
> > ultra-simple classes for SoC devices and such.
>
> I bet it will.  I've ported my old frame buffer patch to use it, and
> it saved a lot of code.
> 
> Hm, I wonder if the frame buffer people ever intregrated that patch...

I had a patch that add class_device to struct fb_info. This was 3-4 months ago. James merged some of them
and then disappeared...

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
E' stato a causa di una donna che ho cominciato a bere e non ho mai
avuto la cortesia di ringraziarla.
