Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbTKWUq0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 15:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263462AbTKWUq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 15:46:26 -0500
Received: from mail.uni-kl.de ([131.246.137.52]:59643 "EHLO mail.uni-kl.de")
	by vger.kernel.org with ESMTP id S263448AbTKWUqY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 15:46:24 -0500
Date: Sun, 23 Nov 2003 21:45:33 +0100
From: Eduard Bloch <edi@gmx.de>
To: "Brown, Len" <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: not fixed in 2.4.23-rc3 (was: Re: 2.4.22 SMP kernel build for hyper threading P4)
Message-ID: <20031123204532.GA6093@zombie.inka.de>
References: <BF1FE1855350A0479097B3A0D2A80EE0CC886F@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE0CC886F@hdsmsx402.hd.intel.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#include <hallo.h>
* Brown, Len [Sun, Nov 23 2003, 03:16:11PM]:
> > weird 1+2xHT mode.
> 
> Re: BIOS disables CPUSs.
> It would be good to verify that 2.4.21 still works properly on this box
> to verify the hardware isn't hosed.  Also, if your BIOS CMOS has error

It does work fine with 2.4.21, the last part of the log on the mentioned
URL is few hours old.  The hardware looks okay, the box was running for
more than 14 months without any hardware trouble.

> logs, it might be good to read them to see what it is thinking.

I could not find any error logs till now, the BIOS help only says that a
CPU is turned off when a severe error occured.

> Also, does the same 3-cpu configuration result when you boot 2.6?

I cannot promise when I have a chance to test 2.6 there, it's a
production system.

Mfg,
Eduard.
-- 
Eine Freude vertreibt hundert Sorgen.
