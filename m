Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030233AbWADUpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030233AbWADUpo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 15:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030285AbWADUpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 15:45:44 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:54421 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030233AbWADUpn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 15:45:43 -0500
Subject: Re: [2.6.15-rc7-rt1] check_monotonic_clock: monotonic
	inconsistency detected!
From: john stultz <johnstul@us.ibm.com>
To: Mike Galbraith <efault@gmx.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
       Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <5.2.1.1.2.20051231171108.00bd9f40@pop.gmx.net>
References: <5.2.1.1.2.20051231152916.00bd5fd0@pop.gmx.net>
	 <5.2.1.1.2.20051231152916.00bd5fd0@pop.gmx.net>
	 <5.2.1.1.2.20051231171108.00bd9f40@pop.gmx.net>
Content-Type: text/plain
Date: Wed, 04 Jan 2006 12:49:43 -0800
Message-Id: <1136407813.2351.2.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-12-31 at 17:36 +0100, Mike Galbraith wrote:
> At 10:49 AM 12/31/2005 -0500, Steven Rostedt wrote:
> >   And John will
> >probably want to see your dmesg output.

Am I so predictable? :)

> I'll send that off-line upon request.  FWIW, it's not the original boot 
> dmesg output however, but one a freshly booted system...

Please do send a dmesg to me. I'm looking to find which clocksource
caused this warning. Its probably the TSC, which isn't surprising, but I
want to be sure.

thanks
-john


