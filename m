Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbVHHKln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbVHHKln (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 06:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbVHHKln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 06:41:43 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:30081 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750757AbVHHKlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 06:41:42 -0400
Message-ID: <42F736EF.9090506@gmail.com>
Date: Mon, 08 Aug 2005 12:41:51 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: dmitry pervushin <dpervushin@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi
References: <1121025679.3008.10.camel@spirit> <1123492338.4762.96.camel@diimka.dev.rtsoft.ru>
In-Reply-To: <1123492338.4762.96.camel@diimka.dev.rtsoft.ru>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dmitry pervushin napsal(a):

>Index: linux-2.6.10/drivers/spi/Makefile
>===================================================================
>--- linux-2.6.10.orig/drivers/spi/Makefile	1970-01-01 00:00:00.000000000 +0000
>+++ linux-2.6.10/drivers/spi/Makefile	2005-07-15 06:57:39.000000000 +0000
>@@ -0,0 +1,12 @@
>+#
>+# Makefile for the kernel spi bus driver.
>+#
>+
>+obj-$(CONFIG_SPI) += spi-core.o helpers.o
>  
>
But where are helpers?
