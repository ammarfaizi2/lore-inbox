Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbVENVXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbVENVXR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 17:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbVENVXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 17:23:16 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:27404 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261497AbVENVXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 17:23:02 -0400
Date: Sat, 14 May 2005 22:22:55 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] DIE "Russel", DIE! 2
Message-ID: <20050514222255.C15061@flint.arm.linux.org.uk>
Mail-Followup-To: Alexey Dobriyan <adobriyan@gmail.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200505142006.58691.adobriyan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200505142006.58691.adobriyan@gmail.com>; from adobriyan@gmail.com on Sat, May 14, 2005 at 08:06:58PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 14, 2005 at 08:06:58PM +0400, Alexey Dobriyan wrote:
> Third part of the movie will hit cinemas around 29 Apr 2008. ;-)
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

Acked-by: Russell King <rmk@arm.linux.org.uk>

Thanks for catching this.

> --- linux-vanilla/drivers/video/pm3fb.c	2005-05-13 17:55:13.000000000 +0400
> +++ linux-russell/drivers/video/pm3fb.c	2005-05-14 19:39:58.000000000 +0400
> @@ -5,7 +5,7 @@
>   *  Based on code written by:
>   *           Sven Luther, <luther@dpt-info.u-strasbg.fr>
>   *           Alan Hourihane, <alanh@fairlite.demon.co.uk>
> - *           Russel King, <rmk@arm.linux.org.uk>
> + *           Russell King, <rmk@arm.linux.org.uk>
>   *  Based on linux/drivers/video/skeletonfb.c:
>   *	Copyright (C) 1997 Geert Uytterhoeven
>   *  Based on linux/driver/video/pm2fb.c:

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
