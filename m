Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751516AbWADA6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516AbWADA6j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 19:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbWADA6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 19:58:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39371 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751516AbWADA6i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 19:58:38 -0500
Date: Tue, 3 Jan 2006 16:54:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: kyungmin.park@samsung.com
Cc: bunk@stusta.de, dwmw2@infradead.org, linux-mtd@lists.infradead.org,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: drivers/mtd/onenand/: unacceptable stack usage
Message-Id: <20060103165437.2311cfc1.akpm@osdl.org>
In-Reply-To: <0IRK00I50JP6FZ@mmp1.samsung.com>
References: <20051216005505.GW23349@stusta.de>
	<0IRK00I50JP6FZ@mmp1.samsung.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyungmin Park <kyungmin.park@samsung.com> wrote:
>
>  OK. I change the source code. 
>  It is working well on OMAP H4 with 2.6.15-rc4 kernel and LTP fs test is
>  passed.
> 
>  And please apply the recent onenand patch
> 
>  	- check correct manufacturer 
>  	- unlock problem in DDP (Double Density Package)
>  	- add platform_device.h instead of device.h
> 
>  Thank you

These patches are wordwrapped and cannot be applied.

You've included three separate patches in the body of a single email. 
Please don't do that.  One patch per email is preferred.

So please redo these patches against 2.6.15 and resend them, as per
http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt, thanks.
