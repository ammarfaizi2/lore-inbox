Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261792AbUDEIBL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 04:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261797AbUDEIBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 04:01:11 -0400
Received: from linux-bt.org ([217.160.111.169]:5806 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S261792AbUDEIBK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 04:01:10 -0400
Subject: Re: 2.6.5-mc1
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040404194037.09d67c37.akpm@osdl.org>
References: <20040404194037.09d67c37.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1081152075.2835.7.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 05 Apr 2004 10:01:15 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

>   "mc" == "merge candidate", for want of a better name.  This tree holds
>   the patches which are slated for inclusion into Linus's tree in the
>   short-term.
> 
>   As Linus is offline for a week we should expect that the contents of
>   -mc1 will be merged into kernel bitkeeper around April 12.
> 
>   2.6.5-mm1 will consist of all of 2.6.5-mc1 plus other patches.  The
>   separation point is "mc.patch" in the -mm series file - everything before
>   mc.patch is part of both the -mc and -mm kernels and everything after
>   mc.patch is in -mm only.
> 
>   The -mc series probably won't live for very long - I'm releasing it so
>   that people can prepare patches against what Linus's kernel will look
>   like when he returns.

what about this patch?

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5-rc3/2.6.5-rc3-mm4/broken-out/yenta-TI-irq-routing-fix.patch

Actually I need it to make my TI PCMCIA bridge work again.

Regards

Marcel


