Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265992AbUAKVrZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 16:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265994AbUAKVrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 16:47:25 -0500
Received: from waste.org ([209.173.204.2]:59623 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S265992AbUAKVrY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 16:47:24 -0500
Date: Sun, 11 Jan 2004 15:47:16 -0600
From: Matt Mackall <mpm@selenic.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] mark ide-cs broken
Message-ID: <20040111214716.GW18208@waste.org>
References: <20040111111607.A1931@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040111111607.A1931@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 11, 2004 at 11:16:07AM +0000, Russell King wrote:
> Hi,
> 
> After receiving this bug report: http://bugme.osdl.org/show_bug.cgi?id=1457
> and talking to Arjan, it would appear that IDECS is known to be broken.
> Arjan has confirmed that he sees the same behaviour with his PCMCIA CDROM
> using both 2.6 and 2.4.2x kernels.
> 
> Therefore, I suggest that we mark it broken.  The patch below is for 2.6.1
> kernels.

It's still working for me as of 2.6.0 with stock kernel and CF, so
this is probably premature.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
