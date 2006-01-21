Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbWAUMHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbWAUMHR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 07:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWAUMHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 07:07:16 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:30181 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750758AbWAUMHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 07:07:15 -0500
Date: Sat, 21 Jan 2006 07:07:00 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Ingo Molnar <mingo@elte.hu>
cc: john stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RT] don't let printk unconditionally turn on interrupts
In-Reply-To: <20060121102808.GB991@elte.hu>
Message-ID: <Pine.LNX.4.58.0601210706390.27390@gandalf.stny.rr.com>
References: <1137811001.6762.179.camel@localhost.localdomain>
 <20060121102808.GB991@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 21 Jan 2006, Ingo Molnar wrote:

> could you check out the variant in 2.6.15-rt11 - i tweaked it slightly
> over yours, hopefully making the behavior more consistent.

I'll take a look Monday.

Thanks,

-- Steve
