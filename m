Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262324AbVAJQtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262324AbVAJQtU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 11:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbVAJQsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 11:48:46 -0500
Received: from mx1.mail.ru ([194.67.23.121]:30804 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S262324AbVAJQsb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 11:48:31 -0500
From: Alexey Dobriyan <adobriyan@mail.ru>
To: Adam Anthony <aanthony@sbs.com>
Subject: Re: [PATCH] /driver/net/wan/sbs520
Date: Mon, 10 Jan 2005 19:47:33 +0200
User-Agent: KMail/1.6.2
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200501101947.33917.adobriyan@mail.ru>
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jan 2005 07:46:52 -0700, Adam Anthony wrote:

> With the permission of my employer, SBS Technologies, Inc., I have
> released a patch for 2.4 kernels that supports the 520 Series of WAN
> adapters.

My editor shows ^M at the end of every line of new Documentation/Configure.help,
MAINTAINERS (add ~63400 bogus lines!). Please, look at the patch _after_
generating it.

> +obj-$(CONFIG_LANMEDIA)		+=		syncppp.o^M

> +subdir-$(CONFIG_LANMEDIA) += lmc^M

Also random ^M's.
 
--- linux-2.4.28-virgin/drivers/net/wan/sbs520/lnxosl.c
+++ /usr/src/linux-2.4.28/drivers/net/wan/sbs520/lnxosl.c

> +// Programming Language:	C^M
> +// Target Processor:		Any^M
> +// Target Operating System: Linux^M

Well, this is pretty obvious to everyone here. :-)

> +// This software may be used and distributed according to the terms^M
> +// of the GNU General Public License, incorporated herein by reference.^M

Stupid question: do you mean GPL version 2 or something else?

	Alexey
