Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbVBFU73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbVBFU73 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 15:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbVBFU73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 15:59:29 -0500
Received: from projekt.yoobay.net ([62.111.67.101]:33484 "EHLO
	bullshit.yoobay.net") by vger.kernel.org with ESMTP id S261314AbVBFU7V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 15:59:21 -0500
Message-ID: <42068529.80203@qanu.de>
Date: Sun, 06 Feb 2005 21:59:21 +0100
From: Holger Waechtler <holger@qanu.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org,
       linux-dvb <linux-dvb@linuxtv.org>
Subject: Re: [linux-dvb-maintainer] [2.6 patch] DVB: remove bouncing address
 of Alex Woods
References: <20050206202208.GC3129@stusta.de>
In-Reply-To: <20050206202208.GC3129@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Have you ever considered asking on the linux-dvb mailing list for a more 
recent address? stop trolling and do something useful. please.

Bounces are sometimes temporary, contacting linux dvb developers is 
usually easiest over the linux-dvb mailing list. Subscribe there if you 
have a dvb-related problem and want to solve it.

Holger



Adrian Bunk wrote:

>This patch removes the bouncing email address linux-dvb@giblets.org of
>Alex Woods.
>
>Signed-off-by: Adrian Bunk <bunk@stusta.de>
>
>---
>
> drivers/media/dvb/ttusb-dec/ttusb_dec.c  |    4 ++--
> drivers/media/dvb/ttusb-dec/ttusbdecfe.c |    2 +-
> drivers/media/dvb/ttusb-dec/ttusbdecfe.h |    2 +-
> 3 files changed, 4 insertions(+), 4 deletions(-)
>
>--- linux-2.6.11-rc3-mm1-full/drivers/media/dvb/ttusb-dec/ttusbdecfe.h.old	2005-02-06 21:18:09.000000000 +0100
>+++ linux-2.6.11-rc3-mm1-full/drivers/media/dvb/ttusb-dec/ttusbdecfe.h	2005-02-06 21:18:31.000000000 +0100
>@@ -1,7 +1,7 @@
> /*
>  * TTUSB DEC Driver
>  *
>- * Copyright (C) 2003-2004 Alex Woods <linux-dvb@giblets.org>
>+ * Copyright (C) 2003-2004 Alex Woods
>  *
>  * This program is free software; you can redistribute it and/or modify
>  * it under the terms of the GNU General Public License as published by
>--- linux-2.6.11-rc3-mm1-full/drivers/media/dvb/ttusb-dec/ttusb_dec.c.old	2005-02-06 21:18:43.000000000 +0100
>+++ linux-2.6.11-rc3-mm1-full/drivers/media/dvb/ttusb-dec/ttusb_dec.c	2005-02-06 21:18:53.000000000 +0100
>@@ -1,7 +1,7 @@
> /*
>  * TTUSB DEC Driver
>  *
>- * Copyright (C) 2003-2004 Alex Woods <linux-dvb@giblets.org>
>+ * Copyright (C) 2003-2004 Alex Woods
>  *
>  * This program is free software; you can redistribute it and/or modify
>  * it under the terms of the GNU General Public License as published by
>@@ -1583,7 +1583,7 @@
> module_init(ttusb_dec_init);
> module_exit(ttusb_dec_exit);
> 
>-MODULE_AUTHOR("Alex Woods <linux-dvb@giblets.org>");
>+MODULE_AUTHOR("Alex Woods");
> MODULE_DESCRIPTION(DRIVER_NAME);
> MODULE_LICENSE("GPL");
> MODULE_DEVICE_TABLE(usb, ttusb_dec_table);
>--- linux-2.6.11-rc3-mm1-full/drivers/media/dvb/ttusb-dec/ttusbdecfe.c.old	2005-02-06 21:19:01.000000000 +0100
>+++ linux-2.6.11-rc3-mm1-full/drivers/media/dvb/ttusb-dec/ttusbdecfe.c	2005-02-06 21:19:06.000000000 +0100
>@@ -1,7 +1,7 @@
> /*
>  * TTUSB DEC Frontend Driver
>  *
>- * Copyright (C) 2003-2004 Alex Woods <linux-dvb@giblets.org>
>+ * Copyright (C) 2003-2004 Alex Woods
>  *
>  * This program is free software; you can redistribute it and/or modify
>  * it under the terms of the GNU General Public License as published by
>
>
>
>  
>
