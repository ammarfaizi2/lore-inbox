Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbVEPDRh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbVEPDRh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 23:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbVEPDRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 23:17:33 -0400
Received: from mail.dvmed.net ([216.237.124.58]:61849 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261257AbVEPDRb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 23:17:31 -0400
Message-ID: <428810C3.3060308@pobox.com>
Date: Sun, 15 May 2005 23:17:23 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] hp100: fix card names
References: <20050421111541.GA24697@elf.ucw.cz>
In-Reply-To: <20050421111541.GA24697@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Those cards really need A in their names. Otherwise it is pretty hard
> to find anything about them on the net.
> 
> Signed-off-by: Pavel Machek <pavel@suse.cz>
> 
> --- clean/drivers/net/hp100.c	2005-03-03 12:34:19.000000000 +0100
> +++ linux/drivers/net/hp100.c	2005-03-22 12:20:53.000000000 +0100
> @@ -13,8 +13,8 @@
>  ** This driver has only been tested with
>  ** -- HP J2585B 10/100 Mbit/s PCI Busmaster
>  ** -- HP J2585A 10/100 Mbit/s PCI 
> -** -- HP J2970  10 Mbit/s PCI Combo 10base-T/BNC
> -** -- HP J2973  10 Mbit/s PCI 10base-T
> +** -- HP J2970A 10 Mbit/s PCI Combo 10base-T/BNC
> +** -- HP J2973A 10 Mbit/s PCI 10base-T


OK, but failed to apply.


