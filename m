Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753329AbWKFQDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753329AbWKFQDE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 11:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753331AbWKFQDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 11:03:04 -0500
Received: from www.osadl.org ([213.239.205.134]:7058 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1753329AbWKFQDC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 11:03:02 -0500
Subject: Re: Re: [2.6.19-rc1   APIC BUG?] kernel 2.6.19-rc1 or later can
	not generate ISA irq properly on DUAL-CPU system.
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Komuro <komurojun-mbn@nifty.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <23488566.296101161695417305.komurojun-mbn@nifty.com>
References: <1161615339.22373.30.camel@localhost.localdomain>
	 <20061022162948.1cf26ad6.komurojun-mbn@nifty.com>
	 <23488566.296101161695417305.komurojun-mbn@nifty.com>
Content-Type: text/plain
Date: Mon, 06 Nov 2006 17:05:03 +0100
Message-Id: <1162829103.4715.198.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-24 at 22:10 +0900, Komuro wrote:
> >> kernel 2.6.19-rc1 or later can not generate ISA irq properly on DUAL-CPU sy
> stem.
>
> Here is the output of /proc/interrupts

Can you please boot with "apic=verbose" on the command line and send me
the full boot log ?

Thanks,

	tglx


