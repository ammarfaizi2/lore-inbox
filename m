Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932430AbWAXCck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbWAXCck (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 21:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbWAXCck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 21:32:40 -0500
Received: from [205.233.219.253] ([205.233.219.253]:923 "EHLO
	conifer.conscoop.ottawa.on.ca") by vger.kernel.org with ESMTP
	id S932430AbWAXCcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 21:32:39 -0500
Date: Mon, 23 Jan 2006 21:24:23 -0500
From: Jody McIntyre <scjody@modernduck.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] update the i386 defconfig
Message-ID: <20060124022423.GR13178@conscoop.ottawa.on.ca>
References: <20060119201046.GY19398@stusta.de> <20060120040326.GF13178@conscoop.ottawa.on.ca> <20060123235416.GD3590@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060123235416.GD3590@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2006 at 12:54:16AM +0100, Adrian Bunk wrote:
> 
> As the patch description said, the i386 defconfig hasn't been updated 
> for some time, and I'm therefore updating it with the semantics "the 
> kernel that successfully runs on my computer".

If 1394 doesn't successfully run on your computer, I'd like to know
the details.

Cheers,
Jody

> I have no problem if someone wants to maintain the i386 defconfig with a 
> different semantics, but as long as noone steps up to maintain it, 
> I plan to occasionally update it with the semantics "my .config".
> 
> > Cheers,
> > Jody
> 
> cu
> Adrian
> 
> -- 
> 
>        "Is there not promise of rain?" Ling Tan asked suddenly out
>         of the darkness. There had been need of rain for many days.
>        "Only a promise," Lao Er said.
>                                        Pearl S. Buck - Dragon Seed

-- 
