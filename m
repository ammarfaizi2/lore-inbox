Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262515AbVBXV6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262515AbVBXV6x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 16:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262514AbVBXV6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 16:58:52 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:58118 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262511AbVBXV4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 16:56:04 -0500
Date: Thu, 24 Feb 2005 22:56:00 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Pete Zaitcev <zaitcev@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/block/ub.c: make a struct static
Message-ID: <20050224215600.GL8651@stusta.de>
References: <20041129123729.GQ9722@stusta.de> <20041129161438.12271.qmail@web60407.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041129161438.12271.qmail@web60407.mail.yahoo.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2004 at 08:14:38AM -0800, Pete Zaitcev wrote:
> 
> > -struct usb_driver ub_driver = {
> > +static struct usb_driver ub_driver = {
> >  	.owner =	THIS_MODULE,
> 
> I'm pretty sure it was in the Greg's tree for a while. I have it, too.
> Just waiting for a turnaround.

It's still not present in 2.6.11-rc4-mm1.

> -- Pete

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

